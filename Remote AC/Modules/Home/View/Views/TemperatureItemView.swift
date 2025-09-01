import SwiftUI

struct TemperatureItemView: View {
    
    var type: TemperatureItemType
    var selected: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: 96)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.border.opacity(0.15), lineWidth: 1)
                )
                .overlay {
                    VStack {
                        
                        HStack {
                            
                            Spacer()
                            
                            Capsule()
                                .fill(selected ? .colorGreen : .fillsQuaternary.opacity(0.12))
                                .frame(width: 16, height: 16)
                                .padding(.top, 10)
                                .padding(.trailing, 10)
                        }
                        
                        Spacer()
                    }
                }
                .overlay {
                    VStack(spacing: 8) {
                        Image(type.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                        
                        Text(type.title)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
        }
    }
}
