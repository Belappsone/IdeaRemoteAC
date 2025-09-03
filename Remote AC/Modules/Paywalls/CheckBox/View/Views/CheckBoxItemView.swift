import SwiftUI

struct CheckBoxItemView: View {
    
    var item: CheckBoxType
    var alpha: Double
    var titleSize: CGFloat
    var subtitleSize: CGFloat
    
    var body: some View {
        HStack(spacing: 8) {
            Text(item.icon)
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .foregroundStyle(.black)
                    .font(.system(size: titleSize, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .opacity(alpha)
                
                Text(item.description)
                    .foregroundStyle(.black.opacity(0.6))
                    .font(.system(size: subtitleSize, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .opacity(alpha)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
