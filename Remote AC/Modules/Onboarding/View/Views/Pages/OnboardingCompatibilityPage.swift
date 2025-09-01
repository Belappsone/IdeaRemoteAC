import SwiftUI

struct OnboardingCompatibilityPage: View {
    // MARK: Properties
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Image(.ob3)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ContainerInfoView(title: "UNIVERSAL\nCOMPATIBILITY", subtitle: "Works with 100%\nof AC brands", infoViewAlpha: 0, buttonAction: action, restoreAction: {})
                    .padding(.horizontal)
                    .padding(.bottom, 1)
            }
        }
    }
}

#Preview {
    OnboardingCompatibilityPage {}
}
