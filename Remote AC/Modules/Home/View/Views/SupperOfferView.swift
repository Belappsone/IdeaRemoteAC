import SwiftUI

struct SupperOfferView: View {
    
    @ObservedObject private var viewModel = SupperOfferViewModel()
    var closeAction: () -> Void
    var openAction: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .frame(height: 320)
            .overlay {
                VStack {
                    Spacer()
                    
                    Text("🔥")
                        .font(.system(size: 45, weight: .bold))
                        .padding(.bottom, 2)
                    
                    Text("\(viewModel.percent)% " + "OFF".localizable)
                        .foregroundStyle(
                            LinearGradient(colors: [.gradientPink, .gradientYellow], startPoint: .leading, endPoint: .trailing)
                        )
                        .font(.system(size: 36, weight: .bold))
                        .padding(.bottom, 8)
                    
                    Text("Don’t miss your chance!".localizable)
                        .foregroundStyle(.black)
                        .font(.system(size: 22, weight: .bold))
                        .padding(.bottom, 8)
                    
                    Text("Get up to 90% discount while it’s still available. Hurry up to take advantage of all the benefits!".localizable)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.labelsSecondary.opacity(0.6))
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.bottom)
                    
                    GradientButton(text: "I want to!".localizable, size: 50) {
                        openAction()
                    }
                    .padding(.bottom, 24)
                }
                .padding(.horizontal)
            }
            .overlay {
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
                                .opacity(0.3)
                        }
                        .padding(.top, 25)
                        .padding(.horizontal, 25)
                    }
                    
                    Spacer()
                }
            }
    }
}

#Preview {
    SupperOfferView(closeAction: {}, openAction: {})
}


final class SupperOfferViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var percent: Int = 100
    var timer: Timer?
    
    // MARK: Init
    
    init() {
        startTimer()
    }
    
    // MARK: Methods
    
    func startTimer() {
       timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.percent <= 0 {
                self.timer?.invalidate()
                self.timer = nil
            } else {
                self.percent -= 1
            }
        }
    }
}
