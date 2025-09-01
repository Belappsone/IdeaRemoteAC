import SwiftUI

struct SnowflakeLoader: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.fillsQuaternary.opacity(0.1))
                .frame(height: 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.colorBlue)
                .frame(width: progress * 300, height: 10)
            
            Image(systemName: "snowflake")
                .foregroundColor(.blue)
                .padding(.all, 3)
                .background(.white)
                .clipShape(Capsule())
                .frame(width: 30, height: 30)
                .offset(x: progress * 300 - 15)
        }
        .frame(width: 300)
        .padding()
        .onAppear {
            withAnimation(.linear(duration: 3.0)) {
                progress = 0.8
            }
        }
    }
}
