import SwiftUI

struct SettingsItemView: View {
    
    var type: SettingsModel
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
                .frame(height: 56)
                .overlay {
                    HStack {
                        Image(type.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .padding(.leading, 12)
                        
                        Text(type.title)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.leading, 10)
                        
                        
                        Spacer()
                        
                        Image(.arrowIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 11, height: 20)
                            .padding(.trailing, 16)
                    }
                }
                .cornerRadius(20)
        }
    }
}

#Preview {
    SettingsItemView(type: .contact) {}
}
