import SwiftUI

struct OtherButtonItemView: View {
    
    @Binding var isConnect: Bool
    var type: OtherButtonType
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            if isConnect {
                action()
            }
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
                            .foregroundStyle(isConnect ? .green : .black.opacity(0.2))
                            .font(.system(size: 17, weight: .semibold))
                    case .swing:
                        Text("Swing".localizable)
                            .foregroundStyle(.black.opacity(isConnect ? 1 : 0.2))
                            .font(.system(size: 17, weight: .semibold))
                    case .timer:
                        Text("Timer".localizable)
                            .foregroundStyle(.black.opacity(isConnect ? 1 : 0.2))
                            .font(.system(size: 17, weight: .semibold))
                    }
                   
                }
        }
    }
}
