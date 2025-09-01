import SwiftUI

struct OnboardingWelcomePage: View {
    // MARK: Properties
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Image(.ob1)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ContainerInfoView(
                    title: "WELCOME\nTO REMOTE AC",
                    subtitle: "Control your air conditioner\neffortlessly from your smartphone",
                    infoViewAlpha: 0,
                    buttonAction: action, restoreAction: {})
                .padding(.horizontal)
                .padding(.bottom, 1)
            }
        }
    }
}

#Preview {
    OnboardingWelcomePage {}
}
