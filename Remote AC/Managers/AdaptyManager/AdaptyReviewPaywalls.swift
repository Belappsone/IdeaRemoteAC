import Foundation

enum AdaptyRivewPlacementKey: String {
    case mainReviewPlacement = "main_review_placement"
    case offerReviewPlacement = "offer_review_placement"
}

final class AdaptyReviewingState {
    private enum Constants {
        static let keyBundle = "CFBundleShortVersionString"
    }
    
    static func replacementPaywall() async {
        guard let appVersion = Bundle.main.infoDictionary?[Constants.keyBundle] as? String else {
            return }
        let reviewVersion: String = AdaptyManager.getGlobalRemoteSettings(key: .reviewVersion)
        
        if appVersion == reviewVersion {
            AdaptyReviewingState.updatePaywall(placement: .main, newPlacement: .mainReviewPlacement)
            AdaptyReviewingState.updatePaywall(placement: .offer, newPlacement: .offerReviewPlacement)
            AdaptyReviewingState.updatePaywall(placement: .promotion, newPlacement: .offerReviewPlacement)
            
            if let reviewSettings = AdaptyManager.shared.generalPaywall?.reviewSettings {
                AdaptyManager.shared.generalPaywall?.globalSettings = reviewSettings
            }
        }
    }
    
    static private func updatePaywall(placement: AdaptyPlacment, newPlacement: AdaptyRivewPlacementKey) {
        guard let oldPlacement = AdaptyManager.shared.paywalls.keys.first(where: { $0.placement == placement.rawValue }),
              let reviewPlacement = AdaptyManager.shared.paywalls.keys.first(where: { $0.placement == newPlacement.rawValue }),
              let replacePlacement = AdaptyManager.shared.paywalls[reviewPlacement] else { return }
        
        let updatedPaywallObject = PaywallObject(placement: oldPlacement.placement, typeName: reviewPlacement.typeName)
        
        AdaptyManager.shared.paywalls.removeValue(forKey: oldPlacement)
        AdaptyManager.shared.paywalls[updatedPaywallObject] = AdaptyPaywallModel(remoteConfig: replacePlacement.remoteConfig, products: replacePlacement.products)
    }
}
