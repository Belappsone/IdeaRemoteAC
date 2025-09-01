import SwiftUI

struct OfferTimeView: View {
    
    var sec: String
    var min: String
    
    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white.opacity(0.8))
                .overlay {
                    Text(min)
                        .foregroundStyle(.colorRed)
                        .font(.system(size: 36, weight: .bold))
                }
                .frame(width: 68, height: 68)
            
            Text(":")
                .foregroundStyle(.black)
                .font(.system(size: 36, weight: .bold))
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.white.opacity(0.8))
                .overlay {
                    Text(sec)
                        .foregroundStyle(.colorRed)
                        .font(.system(size: 36, weight: .bold))
                }
                .frame(width: 68, height: 68)
        }
    }
}

#Preview {
    OfferTimeView(sec: "29", min: "29")
}
