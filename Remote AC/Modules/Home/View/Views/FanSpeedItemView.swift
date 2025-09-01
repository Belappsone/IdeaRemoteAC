import SwiftUI

struct FanSpeedItemView: View {
    
    var type: FanSpeedItemType
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
                            
                            Circle()
                                .frame(width: 16, height: 16)
                                .tint(selected == true ? .colorGreen : .fillsQuaternary.opacity(0.12))
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
                                .fill(.labelsSecondary.opacity(0.6))
                                .frame(width: 8, height: 10)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(type == .medium || type == .high ? .labelsSecondary.opacity(0.6) : .fillsQuaternary.opacity(0.08))
                                .frame(width: 8, height: 15)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(type == .high ? .labelsSecondary.opacity(0.6) : .fillsQuaternary.opacity(0.08))
                                .frame(width: 8, height: 20)
                        }
                        .frame(height: 32)
                        
                        Text(type.title)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
        }
    }
}
