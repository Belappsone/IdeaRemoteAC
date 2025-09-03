import SwiftUI

struct CommentView: View {
    
    var text: String
    var description: String
    
    var body: some View {
        VStack {
            Text(text)
                .foregroundStyle(.black)
                .font(.system(size: 22, weight: .bold))
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.bottom, 4)
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(.labelsSecondary.opacity(0.6))
                .minimumScaleFactor(0.5)
                .lineLimit(3)
                .padding(.horizontal)
            
            Image(.starsIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 40)
                .padding(.bottom)
        }
        .background(.white)
        .cornerRadius(16)
    }
}
