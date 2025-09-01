import SwiftUI

struct SimpleView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = SimpleViewModel()
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                                
                VStack {
                    
                    Text("AC REMOTE\n WITH NO\n LIMITATIONS")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(.black)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    setupPrice()
                        .multilineTextAlignment(.center)
                        .padding(.top, -8)
                        .padding(.bottom)
                        .padding(.horizontal)
                    
                    GradientButton(text: "Start 3-Day Free Trial", size: 50) {
                        
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    InfoView(alpha: 1) {
                        
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
    
    private func setupPrice() -> some View {
        Text("Enjoy all the benefits of the app without restrictions and ads! Enjoy a 3-day free trial with full access to all features, then $2.99/week app or" + " ")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(0.6))
        
        + Text("use limited version.")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .underline()
        
        + Text("\nCancel anytime with no charges.")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(0.6))
    }
}

#Preview {
    SimpleView()
}
