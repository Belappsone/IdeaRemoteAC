import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            Color.bgMain
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    ButtonImage(image: .settingsBackIcon, size: 40) {
                        router.pop()
                    }
                    
                    Spacer()
                }
                .overlay {
                    Text("Settings".localizable)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                    
                }
                .padding(.leading, 12)
                
                SettingsOfferBanner(state: viewModel.stateBanner) {
                    if viewModel.stateBanner != .premium {
                        router.showOffer(type: .paywall)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                            
                ScrollView {
                    HStack {
                        Text("Other".localizable)
                            .foregroundStyle(.labelsSecondary.opacity(0.6))
                            .font(.system(size: 15, weight: .regular))
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 8) {
                        SettingsItemView(type: .contact) {
                            ContactSupport.shared.openMailToContactUs()
                        }
                        
                        SettingsItemView(type: .privacy) {
                            viewModel.openPrivacy()
                        }
                        
                        SettingsItemView(type: .terms) {
                            viewModel.openTerms()
                        }
                        
                        SettingsItemView(type: .restore) {
                            viewModel.restore()
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                
                Spacer()
            }
            
            if viewModel.showLoading {
                showLoading()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
