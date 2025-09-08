import SwiftUI

struct LimitedBannerView: View {
    
    @ObservedObject private var viewModel = LimitedBannerViewModel()
    
    var action: () -> Void
    var close: () -> Void
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [Color.white, Color.gradientWhite], startPoint: .leading, endPoint: .trailing)
                )
                .frame(height: 209)
                .overlay {
                    Image(.settingsBannerBg)
                        .resizable()
                }
                .overlay {
                    VStack {
                        Spacer()
                        
                        Text("50% OFF".localizable)
                            .foregroundStyle(
                                LinearGradient(colors: [.gradientPink, .gradientYellow], startPoint: .leading, endPoint: .trailing)
                            )
                            .font(.system(size: 36, weight: .bold))
                        
                        Text("limited offer!".localizable)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.top, -16)
                        
                        GradientButton(text: "I want to!".localizable, size: 50) {
                            action()
                        }
                        .padding(.top, 10)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
                .overlay {
                    VStack {
                        
                        HStack {
                            Spacer()
                            
                            Text("🔥 \(viewModel.min):\(viewModel.sec)")
                                .foregroundStyle(.black)
                                .font(.system(size: 20, weight: .semibold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(.bgMain)
                                .clipShape(Capsule())
                                .padding(.top, 10)
                                .padding(.horizontal, 10)
                        }
                        
                        Spacer()
                    }
                }
                .overlay {
                    VStack {
                        
                        HStack {
                            Button {
                                close()
                            } label: {
                                Image(.closeIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                    .opacity(0.5)
                                    .contentShape(Rectangle())
                                    .padding(20)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
        }
    }
}

#Preview {
    LimitedBannerView {} close: {}
}

final class LimitedBannerViewModel: ObservableObject {
    // MARK: Properties
    
    private var currentTime: Int = 900
    private var timer: Timer?
    
    @Published var min: String = "15"
    @Published var sec: String = "00"
    
    // MARK: Init
    
    init() {
        startTimer()
    }
    
    // MARK: Methods
    
    func startTimer() {
       timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
           self.currentTime -= 1
           self.convertSecondsToMinutesAndSeconds(seconds: self.currentTime)
       }
    }
    
    private func convertSecondsToMinutesAndSeconds(seconds: Int) {
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        
        self.min = String(format: "%02d", minutes)
        self.sec = String(format: "%02d", remainingSeconds)
    }
}
