import SwiftUI

struct SwitcherItemView: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.fillsQuaternary.opacity(0.2), lineWidth: 1)
            .frame(height: 54)
            .overlay {
                HStack {
                    Text("3 days free trial")
                        .foregroundStyle(.black)
                        .font(.system(size: 17, weight: .semibold))
                    
                    Toggle(isOn: $isOn) {}
                    .tint(.colorBlue)
                }
                .padding(.horizontal)
            }
    }
}
