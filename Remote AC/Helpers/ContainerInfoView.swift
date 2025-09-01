import SwiftUI

struct ContainerInfoView: View {
    
    var title: String
    var subtitle: String
    var infoViewAlpha: Double
    
    var buttonAction: () -> Void
    var restoreAction: () -> Void
    
    var body: some View {
        VStack {
            Text(title)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .font(.sfProDisplay(weight: .bold, size: 28))
                .padding(.horizontal)
                .padding(.top)
            
            Text(subtitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.labelsSecondary.opacity(0.6))
                .font(.system(size: 17, weight: .semibold))
                .padding(.horizontal)
                .padding(.top, 1)
            
            GradientButton(text: "Continue", size: 50) {
                buttonAction()
            }
            .padding(.horizontal)
            .padding(.top, 6)
            
            InfoView(alpha: infoViewAlpha) {
                restoreAction()
            }
            .padding(.top, 10)
            .padding(.bottom)
            
        }
        .background(.white.opacity(0.6))
        .background(Blur().opacity(1))
        .cornerRadius(24)
    }
}

#Preview {
    ContainerInfoView(title: "", subtitle: "", infoViewAlpha: 1, buttonAction: {}, restoreAction: {})
}
