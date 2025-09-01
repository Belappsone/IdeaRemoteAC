import SwiftUI

struct SearchItemView: View {
    
    var item: SearchItemModel
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [.white, .gradientWhite], startPoint: .leading, endPoint: .trailing)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.labelsSecondary.opacity(0.15), lineWidth: 1)
                }
                .frame(height: 50)
                .overlay {
                    HStack {
                        Image(.conditionerIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.leading, 6)
                        
                        Text(item.name)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.black)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Image(item.selected ? .circleBlueIcon : .circleEmptyIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(.trailing, 12)
                    }
                }
        }
    }
}
