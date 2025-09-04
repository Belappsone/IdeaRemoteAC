import SwiftUI

final class SettingsViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    
    var stateBanner: SettingsOfferBannerState {
        let product = AdaptyManager.getCurrentProduct(for: .offer)
        if product.isEmpty {
            if AdaptyManager.isSubscribeAdaptyActive {
                return .premium
            } else {
                return .noTrial
            }
        } else {
            if AdaptyManager.isSubscribeAdaptyActive {
                return .premium
            } else {
                return product[0].introductoryDiscount?.paymentMode == .freeTrial ? .trial : .noTrial
            }
        }
    }
    
    func openPrivacy() {
        if let url = URL(string: AppConfig.privacy) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
        }
    }
    
    func openTerms() {
        if let url = URL(string: AppConfig.terms) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
        }
    }
    
    func restore() {
        showLoading = true
        Task {
            _ = await AdaptyManager.shared.restore()
            showLoading = false
        }
    }
}
