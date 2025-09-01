import SwiftUI

struct InstructionView: View {
    
    var body: some View {
            VStack() {
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(.closeIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
                
                VStack(spacing: 12) {
                    InstructionItemView(title: "🔌 1. Turn on the air conditioner", description: "Switch your AC to standby mode using the remote or panel.")
                    
                    InstructionItemView(title: "📶 2. Enable Wi-Fi on the AC", description: "Go to your AC's Wi-Fi settings and start the pairing process (look for a blinking Wi-Fi icon).")
                    
                    InstructionItemView(title: "📱 3. Select your phone’s Wi-Fi", description: "On the AC, choose the same Wi-Fi network your phone is connected to.")
                    
                    InstructionItemView(title: "🔍 4. Connect via the app", description: "Open the app, tap “Add device”, and follow the steps to connect your AC.")
                        .padding(.bottom)
                }
                
                GradientButton(text: "Continue", size: 50) {
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(.white)
            .cornerRadius(16)
    }
}
