import SwiftUI
import StoreKit

extension View {
    func haptic() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    func showLoading() -> some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(2)
                .tint(.white)
        }
    }
    
    func showCustomAlert(
        isPresented: Binding<Bool>,
        onGet: @escaping () -> Void
    ) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text("Special Offer!🎁".localizable),
                message: Text("Would you like to receive a special condition?".localizable),
                primaryButton: .default(Text("Get".localizable), action: onGet),
                secondaryButton: .cancel(Text("Cancel".localizable))
            )
        }
    }
}

extension View {
    func onWillAppear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(callback: perform))
    }
}

struct WillAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content.background(UIViewLifeCycleHandler(onWillAppear: callback))
    }
}
