import SwiftUI

struct ErrorsSheetView: View {
    
    var model: ErrorsSheetModel
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(.closeIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            
            VStack {
                Image(model.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56, height: 56)
                
                Text(model.title.localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                
                Text(model.description.localizable)
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
                
                GradientButton(text: "Retry".localizable, size: 50) {
                    
                }
                .padding(.top)
                .padding(.bottom, 24)
            }
            .padding(.horizontal)
        }
        .background(.white)
        .cornerRadius(16)
    }
}

#Preview {
    ErrorsSheetView(model: ErrorsSheetModel(icon: .deviceFindIcon, title: "We couldn’t find any compatible devices.", description: "Make sure your AC is powered on and connected to the same Wi-Fi network as your phone."))
}


struct ErrorsSheetModel {
    var icon: ImageResource
    var title: String
    var description: String
    
    static var defaultModel = [
        ErrorsSheetModel(icon: .deviceFindIcon, title: "We couldn’t find any compatible devices.", description: "Make sure your AC is powered on and connected to the same Wi-Fi network as your phone."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "Couldn’t connect to the device", description: "Check your Wi-Fi signal and try again."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "No Wi-Fi connection found.", description: "Please connect your phone to a Wi-Fi network before continuing."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "Can’t connect to the network.", description: "Double-check your Wi-Fi password and try again."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "The device is currently offline.", description: "Make sure it’s plugged in and connected to Wi-Fi."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "Permissions needed.", description: "Allow location and local network access in Settings to find devices nearby."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "Something went wrong.", description: "Please try again later or check your internet connection."),
        ErrorsSheetModel(icon: .deviceConnectIcon, title: "You're offline.", description: "Please connect to the internet and try again."),
    ]
}
