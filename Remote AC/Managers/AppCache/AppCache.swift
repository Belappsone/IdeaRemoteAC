import SwiftUI

enum AppCacheKeys: String {
    case countLaunch
    case showPromotionBanner
    case showOffer
    case selectedItem
    case selectedItems
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
    
    static var selectedItem: SearchItemModel? {
           get {
               guard let data = UserDefaults.standard.data(forKey: AppCacheKeys.selectedItem.rawValue) else { return nil }
               return try? JSONDecoder().decode(SearchItemModel.self, from: data)
           }
           set {
               if let newValue = newValue,
                  let data = try? JSONEncoder().encode(newValue) {
                   UserDefaults.standard.set(data, forKey: AppCacheKeys.selectedItem.rawValue)
               } else {
                   UserDefaults.standard.removeObject(forKey: AppCacheKeys.selectedItem.rawValue)
               }
           }
       }
       
       // MARK: - Массив выбранных элементов
       static var selectedItems: [SearchItemModel] {
           get {
               guard let data = UserDefaults.standard.data(forKey: AppCacheKeys.selectedItems.rawValue) else { return [] }
               return (try? JSONDecoder().decode([SearchItemModel].self, from: data)) ?? []
           }
           set {
               if let data = try? JSONEncoder().encode(newValue) {
                   UserDefaults.standard.set(data, forKey: AppCacheKeys.selectedItems.rawValue)
               }
           }
       }
}
