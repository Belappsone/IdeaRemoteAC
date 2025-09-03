import UIKit

enum SettingsModel {
    case contact
    case privacy
    case terms
    case restore
    
    var title: String {
        switch self {
        case .contact:
            return "Contact Us".localizable
        case .privacy:
            return "Privacy Policy".localizable
        case .terms:
            return "Terms of Use".localizable
        case .restore:
            return "Restore Purchase".localizable
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .contact:
            return .settingsContactIcon
        case .privacy:
            return .settingsPrivacyIcon
        case .terms:
            return .settingsTermsIcon
        case .restore:
            return .settingsRestoreIcon
        }
    }
}

enum SettingsOfferBannerState {
    case trial
    case noTrial
    case premium
}
