import SwiftUI

final class OfferViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCloseButton = false
    @Published var min: String = "15"
    @Published var sec: String = "00"
    
    private var timer: Timer?
    private var currentTime: Int = 900
    
    var placement: AdaptyPlacment
    var showType: OfferType
    
    // MARK: Init
    
    init(showType: OfferType, placement: AdaptyPlacment = .offer) {
        self.placement = placement
        self.showType = showType
        startTimer()
    }
    
    // MARK: Adapty Keys
    
    var isTrial: Bool {
        if product.isEmpty {
            return false
        } else {
            return product[0].introductoryDiscount?.paymentMode == .freeTrial ? true : false
        }
    }
    
    let showAds: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showAds)
    lazy var product = AdaptyManager.getCurrentProduct(for: placement)
    
    lazy var termPrivacyAlpha: Double = AdaptyManager.getRemoteValue(for: placement, key: .termPrivacyAlpha)
    var continueSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: placement, key: .continueSize)
        return CGFloat(size)
    }
    lazy var continueText: String = AdaptyManager.getRemoteValue(for: placement, key: .continueText)
    
    var priceText: String {
        if product.isEmpty {
            return "-:-"
        } else {
            let price = AdaptyManager.price(for: product[0])
            let period = AdaptyManager.period(for: product[0])
            
            if product[0].introductoryDiscount?.paymentMode == .freeTrial {
                return "Enjoy all the benefits of the app without restrictions and ads! Use 3 days trial version and after %price%/%period%!".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
                
            } else {
                return "Enjoy all the benefits of the app without restrictions and ads! Only %price%/%period%!".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
            }
        }
    }
    var priceSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: placement, key: .priceSize)
        return CGFloat(size)
    }
    lazy var priceAlpha: Double = AdaptyManager.getRemoteValue(for: placement, key: .priceAlpha)
    var closeSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: placement, key: .closeSize)
        return CGFloat(size)
    }
    lazy var closeAlpha: Double = AdaptyManager.getRemoteValue(for: placement, key: .closeAlpha)
    lazy var closeDelay: Double = AdaptyManager.getRemoteValue(for: placement, key: .closeDelay)
    
    // MARK: Mehtods
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTrigger), userInfo: nil, repeats: true)
    }
    
    private func convertSecondsToMinutesAndSeconds(seconds: Int) {
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        
        self.min = String(format: "%02d", minutes)
        self.sec = String(format: "%02d", remainingSeconds)
    }
}

// MARK: - TimerSubscription
private extension OfferViewModel {
    @objc func timerTrigger() {
        if currentTime <= 0 {
            currentTime = 900
        } else {
            currentTime -= 1
            convertSecondsToMinutesAndSeconds(seconds: currentTime)
        }
    }
}
