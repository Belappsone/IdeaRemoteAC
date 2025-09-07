import SwiftUI

struct TurnButtonView: View {
    
    var type: TurnType
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(type.gradient)
                .frame(height: 50)
                .overlay {
                    Text(type.title)
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))
                }
        }
    }
}

#Preview {
    TurnButtonView(type: .turnOff) {}
}
