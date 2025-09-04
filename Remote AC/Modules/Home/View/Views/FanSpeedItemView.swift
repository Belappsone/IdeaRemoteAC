import SwiftUI

struct FanSpeedItemView: View {
    
    @Binding var isConnect: Bool
    var type: FanSpeedItemType
    var selected: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            haptic()
            if isConnect {
                action()
            }
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
                            
                            Circle()
                                .frame(width: 16, height: 16)
                                .tint(!isConnect ? .fillsQuaternary.opacity(0.12) : selected ? .colorGreen : .fillsQuaternary.opacity(0.12))
                                .padding(.top, 10)
                                .padding(.trailing, 10)
                        }
                        
                        Spacer()
                    }
                }
                .overlay {
                    VStack(spacing: 8) {
                        
                        HStack(alignment: .bottom, spacing: 4) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.labelsSecondary.opacity(isConnect ? 0.6 : 0.2))
                                .frame(width: 8, height: 10)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(!isConnect ? .labelsSecondary.opacity(0.2) : type == .medium || type == .high ? .labelsSecondary.opacity(0.6) : .fillsQuaternary.opacity(0.08))
                                .frame(width: 8, height: 15)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(!isConnect ? .labelsSecondary.opacity(0.2) : type == .high ? .labelsSecondary.opacity(0.6) : .fillsQuaternary.opacity(0.08))
                                .frame(width: 8, height: 20)
                        }
                        .frame(height: 32)
                        
                        Text(type.title)
                            .foregroundStyle(.black.opacity(isConnect ? 1 : 0.2))
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
        }
    }
}

#Preview {
    FanSpeedItemView(isConnect: .constant(false), type: .high, selected: true) {}
}
