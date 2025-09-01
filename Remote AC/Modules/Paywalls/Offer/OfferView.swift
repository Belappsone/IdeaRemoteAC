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
                
                OfferTrialView(isTrial: false)
                
                Text("Turn your smartphone into a powerful climate control system!")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 24)
                
                
                Text("🔥")
                    .font(.system(size: 45, weight: .bold))
                
                Text("Offer expires in:")
                    .foregroundStyle(.black)
                    .font(.system(size: 22, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)

                OfferTimeView(sec: viewModel.sec, min: viewModel.min)
                    .padding(.bottom)
                
                Text("✔️ Cancel anytime" + "\n" + "✔️ Full access to all features")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .font(.system(size: 15, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)
                
                
                GradientButton(text: "Start Trial", size: 50) {
                    viewModel.showLoading = true
                }
                .padding(.bottom)
                
                Text("Enjoy all the benefits of the app without restrictions and ads! Use 3 days trial version and after $4.99/week!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .padding(.bottom)
                
                InfoView(alpha: 1) {
                    viewModel.showLoading = true
                    
                }
            }
            .padding(.horizontal)
            
            VStack {
                
                HStack {
                    Button {
                        closePaywall()
                    } label: {
                        Image(.closeIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                    }
                    .padding(.leading)
                    .padding(.top)
                    
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: Properties
    
    func closePaywall() {
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

#Preview {
    OfferView(viewModel: .init(showType: .cancel))
}
