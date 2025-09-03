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
                    
                    
                    switch AdaptyPlacment.mainPlacementIs {
                    case .simplecomment:
                        SimpleCommentView(viewModel: .init(showType: .onboarding))
                            .frame(width: UIScreen.main.bounds.width)
                            .id(4)
                    case .checkbox:
                        CheckBoxView(viewModel: .init(showType: .onboarding))
                            .frame(width: UIScreen.main.bounds.width)
                            .id(4)
                    case .simple:
                        SimpleView(viewModel: .init(showType: .onboarding))
                            .frame(width: UIScreen.main.bounds.width)
                            .id(4)
                    case .switcher:
                        SwitcherView(viewModel: .init(showType: .onboarding))
                            .frame(width: UIScreen.main.bounds.width)
                            .id(4)
                    default:
                        MainView(viewModel: .init(showType: .onboarding))
                            .frame(width: UIScreen.main.bounds.width)
                            .id(4)
                    }
                }
                
            }
            .onChange(of: currentIdex) { _, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
                }
                if newValue == 1 {
                    let showRequest: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showRequestReview)
                    if showRequest {
                        requestReview()
                    }
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
