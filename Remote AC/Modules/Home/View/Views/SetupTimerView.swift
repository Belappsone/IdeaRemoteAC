import SwiftUI

struct SetupTimerView: View {
    
    @State var timer: Int = .zero
    var setupAction: () -> Void
    var closeAction: () -> Void
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                
                Button {
                    haptic()
                    closeAction()
                } label: {
                    Image(.closeIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            
            VStack {
                
                Image(.timerIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                
                Text("Set Timer".localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                    .padding(.top, 12)
                
                Text("Automatically power off the air conditioner after the selected time.".localizable)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
                    .padding(.top, 2)
                
                HStack {
                    
                    Button {
                        haptic()
                        if timer != 0 {
                            timer -= 5
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image(.minusIcon)
                            }
                            .shadow(color: .border.opacity(0.3), radius: 2)
                    }
                    
                    Text(conerterTimer)
                        .foregroundStyle(.black)
                        .font(.system(size: 34, weight: .bold))
                        .padding(.horizontal, 20)
                    
                    Button {
                        haptic()
                        timer += 5
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image(.plusIcon)
                            }
                            .shadow(color: .border.opacity(0.3), radius: 2)
                    }
                    
                }
                .padding(.top, 10)
                .padding(.horizontal)
                
                Text("Turn-off timer range: 5 minutes – 12 hours".localizable)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.labelsSecondary.opacity(0.3))
                    .minimumScaleFactor(0.5)
                    .padding(.top, 5)
                
                GradientButton(text: "Apply".localizable, size: 50) {
                    setupAction()
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
                .padding(.top, 10)
            }
        }
        .background(.white)
        .cornerRadius(16)
    }
    
    var conerterTimer: String {
        let minutes = (timer % 3600) / 60
        let remainingSeconds = timer % 60
        
        return String(format: "%02d", minutes) + ":" + String(format: "%02d", remainingSeconds)
    }
}

#Preview {
    SetupTimerView(setupAction: {}, closeAction: {})
}
