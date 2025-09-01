import SwiftUI

struct CheckBoxItemView: View {
    
    var item: CheckBoxType
    
    var body: some View {
        HStack(spacing: 8) {
            Text(item.icon)
                .font(.system(size: 20, weight: .semibold))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .foregroundStyle(.black)
                    .font(.system(size: 17, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Text(item.description)
                    .foregroundStyle(.black.opacity(0.6))
                    .font(.system(size: 11, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
