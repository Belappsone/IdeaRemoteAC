import SwiftUI

struct ButtonTemperatureView: View {
    
    @Binding var isConnect: Bool
    var type: ButtonTemperatureType
    var action: () -> Void
    
    var body: some View {
        VStack {
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
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(type.image)
                            .opacity(isConnect ? 1 : 0.2)
                    }
                    .shadow(color: .border.opacity(0.3), radius: 2)
            }
        }
    }
}

#Preview {
    ButtonTemperatureView(isConnect: .constant(false), type: .minus) {}
}
