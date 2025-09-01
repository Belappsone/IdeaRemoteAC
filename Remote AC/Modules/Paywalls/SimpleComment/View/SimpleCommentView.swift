import SwiftUI

struct SimpleCommentView: View {
    // MARK: Properties
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel = SimpleCommentViewModel()
    
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
                
                VStack {
                    Text("SMART\nCLIMATE CONTROL")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .font(.system(size: 28, weight: .bold))
                        .padding(.horizontal)
                        .padding(.top)
                    
                    useLimitedText()
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            closePaywall()
                        }
                        .padding(.horizontal)
                        .padding(.top, -8)
                        .padding(.bottom, 4)
                    
                    Text("3-days free and then $9.99/week. Automatic renewal.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.labelsSecondary.opacity(0.6))
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    GradientButton(text: "Continue", size: 50) {
                        viewModel.showLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.viewModel.showLoading = false
                            self.viewModel.showCancelOffer = true
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    InfoView(alpha: 1) {
                        viewModel.showLoading = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(.white.opacity(0.8))
                .background(Blur().opacity(1))
                .cornerRadius(24)
                .padding(.horizontal)
            }
            
            if viewModel.showLoading {
                showLoading()
            }
        }
        .navigationBarBackButtonHidden()
        .showCustomAlert(isPresented: $viewModel.showCancelOffer) {
            router.showOffer(type: .cancel)
        }
    }
    
    private func useLimitedText() -> some View {
        Text("Start using the app with no limits or" + " ")
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .font(.system(size: 17, weight: .semibold))
        
        + Text("use limited version.")
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .font(.system(size: 17, weight: .semibold))
            .underline()
    }
    
    private func closePaywall() {
        haptic()
        router.showMain()
    }
}

#Preview {
    SimpleCommentView()
}
