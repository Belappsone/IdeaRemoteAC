import SwiftUI

struct OfferTrialView: View {
    
    var isTrial: Bool
    
    var body: some View {
        VStack {
            Text(isTrial ? "3-DAY" : "50% OFF")
                .foregroundStyle(.white)
                .font(.sfProDisplay(weight: .heavy, size: 49))
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(12)
                .shadow(color: .shadowBlue.opacity(0.43), radius: 8, x: 0, y: 8)
                .zIndex(1)
            
            
            Text("LIMITED TIME!")
                .font(.sfProDisplay(weight: .heavy, size: 36))
                .minimumScaleFactor(0.5)
                .foregroundStyle(
                    LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .top, endPoint: .bottom)
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(12)
                .offset(y: -14)
        }
    }
}

#Preview {
    OfferTrialView(isTrial: true)
}
