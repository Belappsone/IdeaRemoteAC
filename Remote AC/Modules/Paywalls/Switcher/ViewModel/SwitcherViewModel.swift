import SwiftUI

final class SwitcherViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
    @Published var isOn = false {
        didSet {
            selectedProduct = selectedProduct == 0 ? 1 : 0
        }
    }
    @Published var selectedProduct: Int = .zero
    
    var showType: PaywallShow
    
    // MARK: Init
    
    init(showType: PaywallShow) {
        self.showType = showType
        
        if !product.isEmpty {
            isOn = product[0].introductoryDiscount?.paymentMode == .freeTrial ? true : false
            selectedProduct = 0
        }
    }
    
    // MARK: Adapty Keys
    
    let showOffer: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showOffer)
    let showAds: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showAds)
    
    let product = AdaptyManager.getCurrentProduct(for: .main)
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
    
    var priceSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .priceSize)
        return CGFloat(size)
    }
    var priceAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .priceAlpha)
    var priceText: String {
        if product.isEmpty {
             return "-:-"
        } else {
            let price = AdaptyManager.price(for: product[selectedProduct])
            let period = AdaptyManager.period(for: product[selectedProduct])
            if product[selectedProduct].introductoryDiscount?.paymentMode == .freeTrial {
                return "Enjoy all the benefits of the app without restrictions and ads! Enjoy a 3-day free trial with full access to all features, then %price%/%period% app or".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
            } else {
                return "Enjoy all the benefits of the app without restrictions and ads! Enjoy with full access to all features, %price%/%period% app or".localizable.replacingOccurrences(of: "%price%/%period%", with: price + "/" + period)
            }
        }
    }
}
