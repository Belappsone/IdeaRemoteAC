import SwiftUI

enum TurnType {
    case turnOff
    case turnOn
    case none
    
    var title: String {
        switch self {
        case .turnOff, .none:
            return "TURN ON".localizable
        case .turnOn:
            return "TURN OFF".localizable
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .turnOff:
            return LinearGradient(colors: [.colorOrange, .colorRedGradient], startPoint: .leading, endPoint: .trailing)
        case .turnOn:
            return LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .leading, endPoint: .trailing)
        case .none:
            return LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
        }
    }
}

struct TurnButtonView: View {
    
    var type: TurnType
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            if type != .none {
                action()
            }
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(type.gradient)
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.border.opacity(type == .none ? 0.15 : 0), lineWidth: type == .none ? 1 : 0)
                )
                .overlay {
                    Text(type.title)
                        .foregroundStyle(type == .none ? .labelsSecondary.opacity(0.3) : .white)
                        .font(.system(size: 17, weight: .bold))
                }
        }
    }
}

#Preview {
    TurnButtonView(type: .turnOff) {}
}
