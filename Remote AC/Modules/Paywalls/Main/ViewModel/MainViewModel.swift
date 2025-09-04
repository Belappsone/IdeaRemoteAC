import SwiftUI

final class MainViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
    @Published var selectedProduct: Int = 0
    
    var showType: PaywallShow
    
    // MARK: Init
    
    init(showType: PaywallShow) {
        self.showType = showType
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
}
