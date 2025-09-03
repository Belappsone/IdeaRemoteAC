import SwiftUI

struct SimpleCommentView: View {
    // MARK: Properties
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: SimpleCommentViewModel
    
    var body: some View {
        ZStack {
            Image(.ob4)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    
                    CommentView(text: "Life-changing!".localizable, description: "I got my comfort back in just one week. Now I control my AC without even getting up from the couch!".localizable)
                        .padding(.horizontal)
                    
                    CommentView(text: "Coolness on demand!".localizable, description: "From the first use, I felt the difference. Perfect temperature anywhere in my home!".localizable)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                VStack {
                    Text("SMART\nCLIMATE CONTROL".localizable)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .font(.system(size: 28, weight: .bold))
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    useLimitedText()
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                        .onTapGesture {
                            closePaywallWithAds()
                        }
                        .padding(.horizontal)
                        .padding(.top, -8)
                        .padding(.bottom, 4)
                    
                    Text(viewModel.priceText)
                        .multilineTextAlignment(.center)
                        .font(.system(size: viewModel.priceSize, weight: .regular))
                        .foregroundStyle(.labelsSecondary.opacity(viewModel.priceAlpha))
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    GradientButton(text: viewModel.continueText, sizeFont: viewModel.continueSize, size: 50) {
                        viewModel.showLoading = true
                        Task {
                            let result = await AdaptyManager.shared.purchases(product: viewModel.product[0])
                            viewModel.showLoading = false
                            
                            if result == .success {
                                closePaywall()
                            } else {
                                if viewModel.showOffer {
                                    viewModel.showCancelOffer = true
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    InfoView(alpha: viewModel.termPrivacyAlpha) {
                        viewModel.showLoading = true
                        Task {
                            let result = await AdaptyManager.shared.restore()
                            viewModel.showLoading = false
                            
                            if result == .success {
                                closePaywall()
                            }
                        }
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
        Text("Start using the app with no limits or".localizable + " ")
            .foregroundStyle(.labelsSecondary.opacity(viewModel.limitedAlpha))
            .font(.system(size: viewModel.limitedSize, weight: .semibold))
        
        + Text("use limited version.".localizable)
            .foregroundStyle(.labelsSecondary.opacity(viewModel.limitedAlpha))
            .font(.system(size: viewModel.limitedSize, weight: .semibold))
            .underline()
    }
    
    private func closePaywallWithAds() {
        haptic()
        if viewModel.showAds {
            AdMobInterstitialManager.shared.showInterstitial {
                if viewModel.showType == .onboarding {
                    router.showMain()
                } else {
                    router.pop()
                }
            }
        } else {
            if viewModel.showType == .onboarding {
                router.showMain()
            } else {
                router.pop()
            }
        }
    }
    
    private func closePaywall() {
        haptic()
        if viewModel.showType == .onboarding {
            router.showMain()
        } else {
            router.pop()
        }
    }
}

#Preview {
    SimpleCommentView(viewModel: .init(showType: .paywall))
}
