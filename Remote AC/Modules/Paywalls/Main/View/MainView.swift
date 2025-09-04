import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("AC REMOTE\nWITH NO\nLIMITATIONS".localizable)
                        .foregroundStyle(.black)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.horizontal)
                    

                    useLimiteText()
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            haptic()
                            closePaywallWithAds()
                        }
                        .padding(.top, -8)
                    
                    VStack(spacing: 4) {
                        MainPriceItemView(selectedProduct: $viewModel.selectedProduct, id: 0, isPopular: true, product: viewModel.product[0], size: viewModel.priceSize, alpha: viewModel.priceAlpha) {
                            viewModel.selectedProduct = 0
                        }
                        
                        MainPriceItemView(selectedProduct: $viewModel.selectedProduct, id: 1, isPopular: false, product: viewModel.product[1], size: viewModel.priceSize, alpha: viewModel.priceAlpha) {
                            viewModel.selectedProduct = 1
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 13)
                    .padding(.bottom)
                    
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
                .background(Blur())
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
    
    func useLimiteText() -> some View {
        Text("Start using the app with no limits or".localizable + " ")
            .foregroundStyle(.labelsSecondary.opacity(viewModel.limitedAlpha))
            .font(.system(size: viewModel.limitedSize, weight: .semibold))
        
        +
        
        Text("use limited version.".localizable)
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
    MainView(viewModel: .init(showType: .paywall))
}
