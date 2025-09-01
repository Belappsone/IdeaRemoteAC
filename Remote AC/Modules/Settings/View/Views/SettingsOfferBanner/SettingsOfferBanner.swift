import SwiftUI

struct SettingsOfferBanner: View {
    
    @ObservedObject private var viewModel = SettingsOfferBannerViewModel()
    var state: SettingsOfferBannerState
    var action: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
            )
            .frame(height: 209)
            .overlay {
                if state != .premium {
                    Image(.settingsBannerBg)
                        .resizable()
                        .scaledToFill()
                }
            }
            .clipped()
            .overlay {
                if state != .premium {
                    VStack {
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 6) {
                                Text("🔥")
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("\(viewModel.min):\(viewModel.sec)")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.bgMain)
                            .clipShape(Capsule())
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        }
                        
                        Text(state == .trial ? "3 FREE Days" : "50% OFF")
                            .foregroundStyle(
                                LinearGradient(colors: [.gradientPink, .gradientYellow], startPoint: .leading, endPoint: .trailing)
                            )
                            .font(.system(size: 36, weight: .bold))
                        
                        Text("limited offer!")
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.bottom)
                        
                        GradientButton(text: "Try it now!", size: 50) {
                            action()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                } else {
                    VStack {
                        Spacer()
                        
                        Image(.settingsBannerPrem)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 114, height: 114)
                        
                        Text("Premium activated!")
                            .foregroundStyle(
                                LinearGradient(colors: [.gradientPink, .gradientYellow], startPoint: .leading, endPoint: .trailing)
                            )
                            .font(.system(size: 28, weight: .bold))
                        
                        HStack {
                            Spacer()
                            
                            Text("Thank you for your trust!")
                                .foregroundStyle(.black)
                                .font(.system(size: 13, weight: .regular))
                                .italic()
                        }
                        .padding(.top, -5)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .cornerRadius(20)
            .onAppear {
                viewModel.startTimer()
            }
            .onTapGesture {
                haptic()
                action()
            }
    }
}

#Preview {
    SettingsOfferBanner(state: .premium) {}
}
