import SwiftUI

final class SettingsViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    
    var stateBanner: SettingsOfferBannerState {
        return .trial
    }
}
