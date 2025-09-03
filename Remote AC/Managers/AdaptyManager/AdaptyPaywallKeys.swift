import Foundation

enum PaywallKeys: String {
    case reviewVersion
    case showRequestReview
    case showAds
    case showOpenAds
    case showOffer
    case stepPaywallShow
    case wifiName
    case showWifiName
    case supportEmail
    case shareUrl
    case termsUrl
    case privacyUrl
    
    case priceSize
    case priceAlpha
    case termPrivacyAlpha
    case limitedSize
    case limitedAlpha
    case continueSize
    case continueText
    
    case checkBoxTitleSize
    case checkBoxSubTitleSize
    case checkBoxAlpha
}

enum AdaptyPlacment: String {
    case main = "main_placement"
    case offer = "offer_placement"
    case promotion = "promotion_offer_placement"
}

enum AdaptyPaywallType: String {
    case simplecomment
    case checkbox
    case simple
    case switcher
    case main
    case offer
}

extension AdaptyPlacment {
    static var mainPlacementIs: AdaptyPaywallType {
        if let type = AdaptyPaywallType(rawValue: AdaptyManager.getCurrentPaywall(for: .main)) {
             return type
        } else {
            return AdaptyPaywallType.simple
        }
    }
    
    static var offerPlacementIs: AdaptyPaywallType {
        if let type = AdaptyPaywallType(rawValue: AdaptyManager.getCurrentPaywall(for: .offer)) {
            return type
        } else {
            return AdaptyPaywallType.offer
        }
    }
    
    static var promotionPlacementIs: AdaptyPaywallType {
        if let type = AdaptyPaywallType(rawValue: AdaptyManager.getCurrentPaywall(for: .promotion)) {
            return type
        } else {
            return AdaptyPaywallType.offer
        }
    }
}
