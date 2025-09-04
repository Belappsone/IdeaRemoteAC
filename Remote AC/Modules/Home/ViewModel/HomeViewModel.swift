import SwiftUI

final class HomeViewModel: ObservableObject {
    // MARK: Properies
    
    @Published var fanSpeedIndexSelected: Int? = nil
    @Published var temperatureIndexSelected: Int? = nil
    @Published var showSuperOffer = false
    @Published var isConnectedConditioner = false
    @Published var countTapped: Int = .zero {
        didSet {
            if stepPaywallShow != 0 {
                if countTapped == stepPaywallShow {
                    countTapped = .zero
                    showPaywall?()
                }
            }
        }
    }
    
    @Published var statusButton: TurnType = .none
    @Published var currentCelsium: Int = 20
    @Published var swingType: SwingType = .horizontal
    @Published var ecoMode: EcoType = .off
    @Published var setupTimer = false
    @Published var showTimer = false
    
    var selectedName: String {
       return AppCache.selectedItem?.name ?? ""
    }
    
    let stepPaywallShow: Int = AdaptyManager.getGlobalRemoteSettings(key: .stepPaywallShow)
    let reviewVersion: String = AdaptyManager.getGlobalRemoteSettings(key: .reviewVersion)
    
    var showPaywall: (() -> Void)?
    
    init() {
        if reviewVersion == "" {
            AppCache.showPromotionBanner = true
        }
        if !AppCache.showPromotionBanner && !AdaptyManager.isSubscribeAdaptyActive {
            showSuperOffer = true
            AppCache.showPromotionBanner = true
        }
        checkState()
    }
    
    func checkState() {
        if AppCache.selectedItem == nil {
            statusButton = .none
            isConnectedConditioner = false
        } else {
            isConnectedConditioner = true
            if statusButton == .none {
                statusButton = .turnOff
            }
        }
    }
}
