import SwiftUI
import Adapty

struct MainPriceItemView: View {
    
    @Binding var selectedProduct: Int
    var id: Int
    var isPopular: Bool
    var product: AdaptyPaywallProduct
    var size: CGFloat
    var alpha: Double
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
                            
                            Text(AdaptyManager.periodWith(for: product))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Text(setupPrice())
                                .foregroundStyle(.labelsSecondary.opacity(alpha))
                                .font(.system(size: size, weight: .regular))
                        }
                        .padding(.horizontal, 12)
                    }
            }
        }
            
    }
    
    private func setupPrice() -> String {
        if product.introductoryDiscount?.paymentMode == .freeTrial {
            return "3 days free, then".localizable + " \(AdaptyManager.price(for: product))/\(AdaptyManager.period(for: product))"
        } else {
            let period = AdaptyManager.period(for: product)
            
            var calculatePeriod = ""
            var calcultatePrice = ""
            switch period {
            case "week".localizable:
                calcultatePrice = AdaptyManager.priceDay(for: product)
                calculatePeriod = "day".localizable
            case "month".localizable:
                calcultatePrice = AdaptyManager.priceWeek(for: product)
                calculatePeriod = "week".localizable
            case "year".localizable:
                calcultatePrice = AdaptyManager.priceMonth(for: product)
                calculatePeriod = "month".localizable
            default: calculatePeriod = period
            }
            
            return "\(AdaptyManager.price(for: product))/\(period) (\(calcultatePrice)/\(calculatePeriod))"
        }
    }
}
