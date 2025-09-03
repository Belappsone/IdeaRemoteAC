import SwiftUI

struct GradientButton: View {
    
    var text: String
    var sizeFont: CGFloat = 17
    var size: CGFloat
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .leading, endPoint: .trailing)
                )
                .overlay {
                    Text(text)
                        .foregroundStyle(.white)
                        .font(.system(size: sizeFont, weight: .semibold))
                }
        }
        .frame(height: size)
        .clipShape(Capsule())
        .shadow(color: .shadowSecond.opacity(0.15),  radius: 5, y: 8)
    }
}

#Preview {
    GradientButton(text: "Start Trial", size: 50) {}
}
