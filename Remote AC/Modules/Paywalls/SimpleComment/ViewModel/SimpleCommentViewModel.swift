import SwiftUI

final class SimpleCommentViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false

    var showType: PaywallShow
    
    // MARK: Init
    
    init(showType: PaywallShow) {
        self.showType = showType
    }
    
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
                return "3-days free and then %price%/%period%. Automatic renewal.".localizable.replacingOccurrences(of: "%price%/%period%", with: "\(price)/\(period)")
            } else {
                return "%price%/%period%. Automatic renewal.".localizable.replacingOccurrences(of: "%price%/%period%", with: "\(price)/\(period)")
            }
        }
    }
    var termPrivacyAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .termPrivacyAlpha)
    var limitedSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .limitedSize)
        return CGFloat(size)
    }
    var limitedAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .limitedAlpha)
    var continueSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .continueSize)
        return CGFloat(size)
    }
    var continueText: String = AdaptyManager.getRemoteValue(for: .main, key: .continueText)
}
