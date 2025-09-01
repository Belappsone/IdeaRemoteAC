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
                    
                    CommentView(text: "Life-changing!", description: "I got my comfort back in just one week. Now I control my AC without even getting up from the couch!")
                        .padding(.horizontal)
                    
                    CommentView(text: "Coolness on demand!", description: "From the first use, I felt the difference. Perfect temperature anywhere in my home!")
                        .padding(.horizontal)
                }
                
                Spacer()
                
                ContainerInfoView(title: "USER\nREVIEWS", subtitle: "See what people love\nabout RemoteAC", infoViewAlpha: 0, buttonAction: action, restoreAction: {})
                    .padding(.horizontal)
                    .padding(.bottom, 1)
            }
        }
    }
}

#Preview {
    OnboardingUserReviewPage {}
}

struct CommentView: View {
    
    var text: String
    var description: String
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundStyle(.black)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.bottom, 4)
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(.labelsSecondary.opacity(0.6))
                .lineLimit(3)
                .padding(.horizontal)
            
            Image(.starsIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 40)
                .padding(.bottom)
        }
        .background(.white)
        .cornerRadius(16)
    }
}
