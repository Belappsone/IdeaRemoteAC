import Foundation

enum CheckBoxType {
    case interface
    case remote
    case energy
    case updates
    case freeDays
    case premium
    
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
            return "Intuitive interface"
        case .remote:
            return "Remote control"
        case .energy:
            return "Energy efficiency"
        case .updates:
            return "Updates and improvements"
        case .freeDays:
            return "Three days free"
        case .premium:
            return "Premium Comfort"
        }
    }
    
    var description: String {
        switch self {
        case .interface:
            return "Control your AC in just 2 taps - simple as texting!"
        case .remote:
            return "Adjust temperature from anywhere."
        case .energy:
            return "Smart energy savings"
        case .updates:
            return "We make the app better every 2 weeks"
        case .freeDays:
            return "Try all premium features risk-free"
        case .premium:
            return "Only $4.99/week. Cancel anytime."
        }
    }
}
