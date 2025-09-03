import SwiftUI

struct CheckBoxView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: CheckBoxViewModel
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack {
                    Text("AC REMOTE\nWITH NO LIMITATIONS".localizable)
                        .foregroundStyle(.black)
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    useLimitedText()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, -4)
                        .padding(.bottom)
                        .onTapGesture {
                            closePaywallWithAds()
                        }
                    
                    VStack(spacing: 6) {
                        CheckBoxItemView(item: .interface, alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                        CheckBoxItemView(item: .remote, alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                        CheckBoxItemView(item: .energy, alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                        CheckBoxItemView(item: .updates, alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                        if viewModel.productIsTrial {
                            CheckBoxItemView(item: .freeDays, alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                        }
                        CheckBoxItemView(item: .premium(price: viewModel.priceText), alpha: viewModel.checkBoxAlpha, titleSize: viewModel.checkBoxTitleSize, subtitleSize: viewModel.checkBoxSubTitleSize)
                    }
                    .padding(.bottom)
                    
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
            .font(.system(size: viewModel.limitedSize, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(viewModel.limitedAlpha))
        
        + Text("use limited version.".localizable)
            .font(.system(size: viewModel.limitedSize, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(viewModel.limitedAlpha))
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
    CheckBoxView(viewModel: .init(showType: .paywall))
}
