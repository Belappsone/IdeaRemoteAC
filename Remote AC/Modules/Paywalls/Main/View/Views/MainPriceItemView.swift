import SwiftUI
import Adapty

struct MainPriceItemView: View {
    
    @Binding var selectedProduct: Int
    var id: Int
    var isPopular: Bool
    var product: AdaptyPaywallProduct
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if isPopular {
                VStack {
                    
                    Text("Most popular".localizable)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .regular))
                        .padding(.vertical, 4)
                        .padding(.horizontal,8)
                        .background(Color.colorBlue)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 50)
            }
            
            Button {
                haptic()
                action()
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedProduct == id ? .colorBlue.opacity(0.4) : .fillsQuaternary.opacity(0.12), lineWidth: 1.5)
                    .frame(height: 56)
                    .overlay {
                        HStack {
                            Image(selectedProduct == id ? .circleBlueIcon : .circleEmptyIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                            
                            Text("Monthly")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Text("3 days free, then $1,49/week")
                                .foregroundStyle(.labelsSecondary.opacity(0.6))
                                .font(.system(size: 13, weight: .regular))
                        }
                        .padding(.horizontal, 12)
                    }
            }
        }
            
    }
}
