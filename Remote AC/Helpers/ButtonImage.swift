import SwiftUI

struct ButtonImage: View {
    // MARK: Properties
    
    var image: ImageResource
    var size: CGFloat
    var action: () -> Void

    var body: some View {
        Button {
            haptic()
            action()
        } label: {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    ButtonImage(image: .settingsIcon, size: 32) {}
}
