import UIKit

enum OtherButtonType {
    case eco
    case swing
    case timer
}

enum FanSpeedItemType {
    case low
    case medium
    case high
    
    var title: String {
        switch self {
        case .low:
            return "Low".localizable
        case .medium:
            return "Mid".localizable
        case .high:
            return "High".localizable
        }
    }
}

enum TemperatureItemType {
    case cool
    case heat
    
    var title: String {
        switch self {
        case .cool:
            return "Cool".localizable
        case .heat:
            return "Heat".localizable
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .cool:
            return .coolIcon
        case .heat:
            return .heatIcon
        }
    }
}

enum ButtonTemperatureType {
    case plus
    case minus
    
    var image: ImageResource {
        switch self {
        case .plus:
            return .plusIcon
        case .minus:
            return .minusIcon
        }
    }
}
