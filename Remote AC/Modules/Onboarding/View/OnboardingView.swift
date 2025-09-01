import SwiftUI

struct OnboardingView: View {
    
    @State private var currentIdex = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: .zero) {
                    OnboardingWelcomePage {
                        withAnimation {
                            currentIdex += 1
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .id(0)
                        
                    OnboardingFeedbackPage {
                        withAnimation {
                            currentIdex += 1
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .id(1)
                    
                    OnboardingCompatibilityPage {
                        withAnimation {
                            currentIdex += 1
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .id(2)
                      
                    
                    OnboardingUserReviewPage {
                        withAnimation {
                            currentIdex += 1
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .id(3)
                    
            
                    SimpleCommentView()
                        .frame(width: UIScreen.main.bounds.width)
                        .id(4)
//                    switch AdaptyPlacment.mainPlacementIs {
//                    case .main:
//                        ToggleView(viewModel: .init(type: .onboarding))
//                            .frame(width: UIScreen.main.bounds.width)
//                            .id(4)
//                    case .simplecomment:
//                        CommentPaywallView(viewModel: .init(type: .onboarding))
//                            .frame(width: UIScreen.main.bounds.width)
//                            .id(4)
//                    case .checkbox:
//                        CheckboxView(viewModel: .init(type: .onboarding))
//                            .frame(width: UIScreen.main.bounds.width)
//                            .id(4)
//                    case .switcher:
//                        SwitcherView(viewModel: .init(type: .onboarding))
//                            .frame(width: UIScreen.main.bounds.width)
//                            .id(4)
//                    default:
//                        MainPaywallView(viewModel: .init(type: .onboarding))
//                            .frame(width: UIScreen.main.bounds.width)
//                            .id(4)
//                    }
                }
                
            }
            .onChange(of: currentIdex) { _, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
                if newValue == 1 {
//                    DispatchQueue.main.async {
//                        let showRequest: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showRequestReview)
//                        if showRequest {
//                            requestReview()
//                        }
//                    }
                }
            }
        }
        .scrollDisabled(true)
        .background(Color.bgMain)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingView()
}
