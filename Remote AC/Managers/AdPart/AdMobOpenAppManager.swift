import SwiftUI
import GoogleMobileAds

final class AdMobOpenAppManager: NSObject, ObservableObject {
    static let shared = AdMobOpenAppManager()
    
    @Published var isReady = false
    private var appOpenAd: AppOpenAd?
    private var loadTime = Date()
    
    var completionResult: (() -> ())?
    
    private override init() {}
    
    func configure() async {
        let request = Request()
        do {
            let result = try await AppOpenAd.load(with: AppConfig.adOpenApp, request: request)
            self.appOpenAd = result
            self.appOpenAd?.fullScreenContentDelegate = self
            isReady = true
        } catch {
            isReady = false
            print(error)
            print("Error configuring open app ad")
        }
    }
    
    func showOpenApp() {
        let showOpenAds: Bool = AdaptyManager.getGlobalRemoteSettings(key: PaywallKeys.showOpenAds)
        if showOpenAds && AppCache.countLaunch > 1 && !AdaptyManager.isSubscribeAdaptyActive {
            if let gOpenAd = self.appOpenAd,
               let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let rwc = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController,
               wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
                gOpenAd.present(from: rwc)
            } else {
                completionResult?()
            }
        } else {
            completionResult?()
        }
    }
    
    private func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
        let secondsPerHour = 3600.0
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return intervalInHours < Double(thresholdN)
    }
}

// MARK: - GADFullScreenContentDelegate
extension AdMobOpenAppManager: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.isReady = false
            self?.completionResult?()
        }
    }
}
