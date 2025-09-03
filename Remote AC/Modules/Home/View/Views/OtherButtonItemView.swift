import SwiftUI

struct OtherButtonItemView: View {
    
    var type: OtherButtonType
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.border.opacity(0.15), lineWidth: 1)
                )
                .overlay {
                    switch type {
                    case .eco:
                        Text("Eco".localizable)
                            .foregroundStyle(.green)
                            .font(.system(size: 17, weight: .semibold))
                    case .swing:
                        Text("Swing".localizable)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                    case .timer:
                        Text("Timer".localizable)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                   
                }
        }
    }
}
