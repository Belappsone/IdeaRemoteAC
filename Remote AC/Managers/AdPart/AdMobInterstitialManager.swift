import SwiftUI
import GoogleMobileAds

final class AdMobInterstitialManager: NSObject, ObservableObject {
    static let shared = AdMobInterstitialManager()
    
    @Published var isAdReady: Bool = false
    private var interstitialAd: InterstitialAd?
    
    var adDidDismissCompletion: (() -> Void)?
    
    private override init() {}
    
    func configureGoogleAdMob() {
        MobileAds.shared.start(completionHandler: nil)
        loadInterstitialAd()
    }
    
    private func loadInterstitialAd() {
        let request = Request()
        InterstitialAd.load(with: AppConfig.adInterstial, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let ad = ad {
                self.interstitialAd = ad
                self.interstitialAd?.fullScreenContentDelegate = self
                self.isAdReady = true
            } else {
                self.isAdReady = false
                print("Failed to load interstitial ad: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func showInterstitial(completion: @escaping () -> Void) {
        guard let interstitialAd = interstitialAd else {
            completion()
            return
        }
        
        if let rootController = getRootViewController() {
            interstitialAd.present(from: rootController)
            adDidDismissCompletion = completion
        } else {
            completion()
        }
    }
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) else {
            return nil
        }
        
        return windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
}

// MARK: - GADFullScreenContentDelegate
extension AdMobInterstitialManager: FullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        interstitialAd = nil
        isAdReady = false
        loadInterstitialAd()
        adDidDismissCompletion?()
    }
}
