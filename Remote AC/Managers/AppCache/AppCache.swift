import SwiftUI

enum AppCacheKeys: String {
    case countLaunch
    case showPromotionBanner
    case showOffer
}

struct AppCache {
    static var countLaunch: Int {
        get { UserDefaults.standard.integer(forKey: AppCacheKeys.countLaunch.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: AppCacheKeys.countLaunch.rawValue) }
    }
    static var showPromotionBanner: Bool {
        get { UserDefaults.standard.bool(forKey: AppCacheKeys.showPromotionBanner.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: AppCacheKeys.showPromotionBanner.rawValue) }
    }
    static var showOffer: Bool {
        get { UserDefaults.standard.bool(forKey: AppCacheKeys.showOffer.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: AppCacheKeys.showOffer.rawValue) }
    }
}
