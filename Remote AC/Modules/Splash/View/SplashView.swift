import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.bgMain
                .ignoresSafeArea()
            
            Image(.splashIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 145, height: 145)
            
            VStack {
                
                Spacer()
                
                SnowflakeLoader()
                    .padding(.bottom, 60)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SplashView()
}
