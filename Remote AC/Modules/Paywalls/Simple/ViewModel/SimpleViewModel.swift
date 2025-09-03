import SwiftUI

final class SimpleViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
    
    // MARK: Adapty Keys
    
    let showOffer: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showOffer)
    let showAds: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showAds)
    
    let product = AdaptyManager.getCurrentProduct(for: .main)
    var priceSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .priceSize)
        return CGFloat(size)
    }
    var priceAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .priceAlpha)
    var priceText: String {
        if product.isEmpty {
            return "-:-"
        } else {
            let price = AdaptyManager.price(for: product[0])
            let period = AdaptyManager.period(for: product[0])
            if product[0].introductoryDiscount?.paymentMode == .freeTrial {
                return "Enjoy all the benefits of the app without restrictions and ads! Enjoy a 3-day free trial with full access to all features, then %price%/%period% app or".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
            } else {
                return "Enjoy all the benefits of the app without restrictions and ads! Enjoy with full access to all features, %price%/%period% app or".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
            }
        }
    }
    var termPrivacyAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .termPrivacyAlpha)
    var continueSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .continueSize)
        return CGFloat(size)
    }
    var continueText: String = AdaptyManager.getRemoteValue(for: .main, key: .continueText)
    
    var showType: PaywallShow
    
    // MARK: Init
    
    init(showType: PaywallShow) {
        self.showType = showType
    }
}
