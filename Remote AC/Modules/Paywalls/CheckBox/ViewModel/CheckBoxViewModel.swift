import SwiftUI

final class CheckBoxViewModel: ObservableObject {
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
    
    var checkBoxTitleSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .checkBoxTitleSize)
        return CGFloat(size)
    }
    var checkBoxSubTitleSize: CGFloat {
        let size: Int = AdaptyManager.getRemoteValue(for: .main, key: .checkBoxSubTitleSize)
        return CGFloat(size)
    }
    var checkBoxAlpha: Double = AdaptyManager.getRemoteValue(for: .main, key: .checkBoxAlpha)
    
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
    
    var priceText: String {
        if product.isEmpty {
            return "-:-"
        } else {
            let price = AdaptyManager.price(for: product[0])
            let period = AdaptyManager.period(for: product[0])
            
            return price + "/" + period
        }
    }
    var productIsTrial: Bool {
        if product.isEmpty {
            return false
        } else {
            return product[0].introductoryDiscount?.paymentMode == .freeTrial ? true : false
        }
    }
}
