import SwiftUI

struct CheckBoxView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = CheckBoxViewModel()
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                VStack {
                     Text("AC REMOTE\nWITH NO LIMITATIONS")
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
                            closePaywall()
                        }
                    
                    VStack(spacing: 6) {
                        CheckBoxItemView(item: .interface)
                        CheckBoxItemView(item: .remote)
                        CheckBoxItemView(item: .energy)
                        CheckBoxItemView(item: .updates)
                        CheckBoxItemView(item: .freeDays)
                        CheckBoxItemView(item: .premium)
                    }
                    .padding(.bottom)
                    
                    GradientButton(text: "Continue", size: 50) {
                        
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
    
    private func useLimitedText() -> some View {
        Text("Start using the app with no limits or" + " ")
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(0.6))
        
        + Text("use limited version.")
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .underline()
    }
    
    private func closePaywall() {
        haptic()
        router.showMain()
    }
}

#Preview {
    CheckBoxView()
}
