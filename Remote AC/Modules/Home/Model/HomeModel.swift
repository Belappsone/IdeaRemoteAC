import SwiftUI

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
    
    var iconDeselected: ImageResource {
        switch self {
        case .cool:
            return .coolIconDeselected
        case .heat:
            return .heatIconDeselected
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

enum SwingType {
    case horizontal
    case vertical
}

enum EcoType {
    case on
    case off
}

enum TurnType {
    case turnOff
    case turnOn
    
    var title: String {
        switch self {
        case .turnOff:
            return "TURN ON".localizable
        case .turnOn:
            return "TURN OFF".localizable
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .turnOff:
            return LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .leading, endPoint: .trailing)
        case .turnOn:
            return LinearGradient(colors: [.colorOrange, .colorRedGradient], startPoint: .leading, endPoint: .trailing)
        }
    }
}
