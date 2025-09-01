import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Image(.paywallBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("AC REMOTE\nWITH NO\nLIMITATIONS")
                        .foregroundStyle(.black)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.horizontal)
                    

                    useLimiteText()
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            haptic()
                        }
                        .padding(.top, -8)
                    
                    VStack(spacing: 4) {
                        MainPriceItemView(selectedProduct: $viewModel.selectedProduct, id: 0, isPopular: true) {
                            viewModel.selectedProduct = 0
                        }
                        
                        MainPriceItemView(selectedProduct: $viewModel.selectedProduct, id: 1, isPopular: false) {
                            viewModel.selectedProduct = 1
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 13)
                    .padding(.bottom)
                    
                    GradientButton(text: "Start 3-Day Free Trial", size: 50) {
                        viewModel.showLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.showLoading = false
                            viewModel.showCancelOffer = true
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
        Text("Start using the app with no limits or" + " ")
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .font(.system(size: 17, weight: .semibold))
        
        +
        
        Text("use limited version.")
            .foregroundStyle(.labelsSecondary.opacity(0.6))
            .font(.system(size: 17, weight: .semibold))
            .underline()
    }
    
    func closePaywall() {
        
    }
}

#Preview {
    MainView()
}

struct MainPriceItemView: View {
    
    @Binding var selectedProduct: Int
    var id: Int
    var isPopular: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isPopular {
                VStack {
                    
                    Text("Most popular")
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .regular))
                        .padding(.vertical, 4)
                        .padding(.horizontal,8)
                        .background(Color.colorBlue)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 50)
            }
            
            Button {
                haptic()
                action()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedProduct == id ? .colorBlue.opacity(0.4) : .fillsQuaternary.opacity(0.12), lineWidth: 1.5)
                    .frame(height: 56)
                    .overlay {
                        HStack {
                            Image(selectedProduct == id ? .circleBlueIcon : .circleEmptyIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                            
                            Text("Monthly")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Text("3 days free, then $1,49/week")
                                .foregroundStyle(.labelsSecondary.opacity(0.6))
                                .font(.system(size: 13, weight: .regular))
                        }
                        .padding(.horizontal, 12)
                    }
            }
        }
            
    }
}
