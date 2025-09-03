import SwiftUI

struct SwitcherView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: SwitcherViewModel
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    
                    VStack {
                        
                        Text("AC REMOTE\n WITH NO\n LIMITATIONS".localizable)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.black)
                            .padding(.top)
                        
                        SwitcherItemView(isOn: $viewModel.isOn)
                            .padding(.top, -4)
                            .padding(.bottom, 8)
                        
                        setupPrice()
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                            .onTapGesture {
                               closePaywallWithAds()
                            }
                        
                        GradientButton(text: viewModel.continueText, sizeFont: viewModel.continueSize, size: 50) {
                            viewModel.showLoading = true
                            Task {
                                let result = await AdaptyManager.shared.purchases(product: viewModel.product[viewModel.selectedProduct])
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
                        .padding(.bottom)
                        
                    }
                    .padding(.horizontal)
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
    
    private func setupPrice() -> some View {
        Text(viewModel.priceText + " ")
            .font(.system(size: viewModel.priceSize, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(viewModel.priceAlpha))
        
        + Text("use limited version.".localizable)
            .font(.system(size: viewModel.priceSize, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(viewModel.priceAlpha))
            .underline()
        
        + Text("\n" + "Cancel anytime with no charges.".localizable)
            .font(.system(size: viewModel.priceSize, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(viewModel.priceAlpha))
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
    SwitcherView(viewModel: .init(showType: .paywall))
}
