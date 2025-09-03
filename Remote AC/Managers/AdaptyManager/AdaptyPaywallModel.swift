import Foundation
import Adapty

struct PaywallObject: Hashable {
    let placement: String
    let typeName: String
}

struct AdaptyPaywallModel {
    var remoteConfig: [String: Any]
    var products: [AdaptyPaywallProduct]
    
    mutating func setProductValue(products: [AdaptyPaywallProduct]) {
        self.products = products
    }
    
    mutating func setRemoteConfig(remoteConfig: [String:Any]) {
        self.remoteConfig = remoteConfig
    }
}

struct GeneralPaywall {
    let placementsId: [String]
    var globalSettings: [String: Any]
    var reviewSettings: [String: Any]
    
    static func createGeneralPaywall(data: [String: Any]) -> GeneralPaywall {
        return GeneralPaywall(
            placementsId: (data["placementsId"] as? [String]) ?? [],
            globalSettings: data["globalSettings"] as? [String: Any] ?? [:],
            reviewSettings: data["reviewSettings"] as? [String: Any] ?? [:])
    }
}

enum AdaptyPurchaseState {
    case success
    case cancel
    case error
}
