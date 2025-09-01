import SwiftUI

struct ButtonTemperatureView: View {
    
    var type: ButtonTemperatureType
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(type.image)
                    }
                    .shadow(color: .border.opacity(0.3), radius: 2)
            }
        }
    }
}

#Preview {
    ButtonTemperatureView(type: .minus) {}
}
