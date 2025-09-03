import SwiftUI

struct InfoView: View {
    
    var alpha: Double
    var didTapRestore: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                haptic()
                if let url = URL(string: AppConfig.terms) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                }
            } label: {
                Text("Terms".localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 13, weight: .regular))
                    .opacity(alpha)
            }
            
            Spacer()
            
            Button {
                haptic()
                didTapRestore()
            } label: {
                Text("Restore".localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 13, weight: .regular))
                    .opacity(alpha)
            }
            
            Spacer()
            
            Button {
                haptic()
                if let url = URL(string: AppConfig.privacy) {
                    UIApplication.shared.open(url, options: [:], completionHandler: { _ in })
                }
            } label: {
                Text("Privacy".localizable)
                    .foregroundStyle(.black)
                    .font(.system(size: 13, weight: .regular))
                    .opacity(alpha)
            }
            
            Spacer()
        }
    }
}

#Preview {
    InfoView(alpha: 1) {  }
}
