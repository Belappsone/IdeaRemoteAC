import SwiftUI

struct OnboardingUserReviewPage: View {
    // MARK: Properties
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Image(.ob4)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    
                    CommentView(text: "Life-changing!".localizable, description: "I got my comfort back in just one week. Now I control my AC without even getting up from the couch!")
                        .padding(.horizontal)
                    
                    CommentView(text: "Coolness on demand!".localizable, description: "From the first use, I felt the difference. Perfect temperature anywhere in my home!".localizable)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                ContainerInfoView(title: "USER\nREVIEWS".localizable, subtitle: "See what people love\nabout RemoteAC".localizable, infoViewAlpha: 0, buttonAction: action, restoreAction: {})
                    .padding(.horizontal)
                    .padding(.bottom, 1)
            }
        }
    }
}

#Preview {
    OnboardingUserReviewPage {}
}

