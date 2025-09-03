import SwiftUI

struct SwitcherItemView: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.fillsQuaternary.opacity(0.2), lineWidth: 1)
            .frame(height: 54)
            .overlay {
                HStack {
                    Text("Three days free trial".localizable)
                        .foregroundStyle(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Spacer()
                    
                    Toggle(isOn: $isOn) { }
                    .tint(.colorBlue)
                    .frame(width: 50)
                }
                .padding(.horizontal)
            }
    }
}

#Preview {
    SwitcherItemView(isOn: .constant(true))
}
