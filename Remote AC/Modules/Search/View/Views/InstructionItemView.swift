import SwiftUI

struct InstructionItemView: View {
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .multilineTextAlignment(.leading)
                
                Text(description)
                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
