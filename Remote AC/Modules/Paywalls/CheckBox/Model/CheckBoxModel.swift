import Foundation

enum CheckBoxType {
    case interface
    case remote
    case energy
    case updates
    case freeDays
    case premium(price: String)
    
    var icon: String {
        switch self {
        case .interface:
           return "📱"
        case .remote:
            return "🌍"
        case .energy:
            return "💡"
        case .updates:
            return "🔄"
        case .freeDays:
            return "🎁"
        case .premium:
            return "💎"
        }
    }
    
    var title: String {
        switch self {
        case .interface:
            return "Intuitive interface".localizable
        case .remote:
            return "Remote control".localizable
        case .energy:
            return "Energy efficiency".localizable
        case .updates:
            return "Updates and improvements".localizable
        case .freeDays:
            return "Three days free".localizable
        case .premium:
            return "Premium Comfort".localizable
        }
    }
    
    var description: String {
        switch self {
        case .interface:
            return "Control your AC in just 2 taps - simple as texting!".localizable
        case .remote:
            return "Adjust temperature from anywhere.".localizable
        case .energy:
            return "Smart energy savings".localizable
        case .updates:
            return "We make the app better every 2 weeks".localizable
        case .freeDays:
            return "Try all premium features risk-free".localizable
        case .premium(let price):
            return "Only %price%/%period%. Cancel anytime.".localizable.replacingOccurrences(of: "%price%/%period%", with: price)
        }
    }
}
