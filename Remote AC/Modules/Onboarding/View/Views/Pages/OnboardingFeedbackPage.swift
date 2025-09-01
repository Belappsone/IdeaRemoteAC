import SwiftUI

struct OnboardingFeedbackPage: View {
    // MARK: Properties
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            
            Image(.ob2)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ContainerInfoView(title: "YOUR FEEDBACK\nMATTERS", subtitle: "Help us improve\nRemote AC for you", infoViewAlpha: 0, buttonAction: action, restoreAction: {})
                    .padding(.horizontal)
                    .padding(.bottom, 1)
            }
        }
    }
}

#Preview {
    OnboardingFeedbackPage {}
}
