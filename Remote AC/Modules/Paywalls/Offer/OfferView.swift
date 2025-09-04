import SwiftUI

struct OfferView: View {
    // MARK: Properties
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: OfferViewModel
    
    var body: some View {
        ZStack {
            
            Image(.offerBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                OfferTrialView(isTrial: viewModel.isTrial)
                
                Text("Turn your smartphone into a powerful climate control system!".localizable)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 24)
                
                
                Text("🔥")
                    .font(.system(size: 45, weight: .bold))
                
                Text("Offer expires in:".localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 22, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)

                OfferTimeView(sec: viewModel.sec, min: viewModel.min)
                    .padding(.bottom)
                
                Text("✔️ Cancel anytime".localizable + "\n" + "✔️ Full access to all features".localizable)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .font(.system(size: 15, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)
                
                
                GradientButton(text: viewModel.continueText, sizeFont: viewModel.continueSize, size: 50) {
                    viewModel.showLoading = true
                    Task {
                        let result = await AdaptyManager.shared.purchases(product: viewModel.product[0])
                        viewModel.showLoading = false
                        
                        if result == .success {
                            closePaywall()
                        }
                    }
                }
                .padding(.bottom)
                
                Text(viewModel.priceText)
                    .multilineTextAlignment(.center)
                    .font(.system(size: viewModel.priceSize, weight: .regular))
                    .foregroundStyle(.labelsSecondary.opacity(viewModel.priceAlpha))
                    .padding(.bottom)
                
                InfoView(alpha: 1) {
                    viewModel.showLoading = true
                    Task {
                        let result = await AdaptyManager.shared.restore()
                        viewModel.showLoading = false
                        if result == .success {
                            closePaywall()
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            VStack {
                
                HStack {
                    if viewModel.showCloseButton {
                        Button {
                            closeWithPaywall()
                        } label: {
                            Image(.closeIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: viewModel.closeSize, height: viewModel.closeSize)
                        }
                        .opacity(viewModel.closeAlpha)
                        .padding(.leading)
                        .padding(.top)
                    }
                    
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            if viewModel.showLoading {
                showLoading()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.closeDelay) {
                withAnimation {
                    viewModel.showCloseButton = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
        
    private func closeWithPaywall() {
        if viewModel.showAds {
            AdMobInterstitialManager.shared.showInterstitial {
                switch viewModel.showType {
                case .cancel:
                    router.pop()
                case .push:
                    router.showMain()
                case .paywall:
                    router.pop()
                }
            }
        } else {
            switch viewModel.showType {
            case .cancel:
                router.pop()
            case .push:
                router.showMain()
            case .paywall:
                router.pop()
            }
        }
    }
    
    private func closePaywall() {
        switch viewModel.showType {
        case .cancel, .push:
            router.showMain()
        case .paywall:
            router.pop()
        }
    }
}

#Preview {
    OfferView(viewModel: .init(showType: .cancel))
}
