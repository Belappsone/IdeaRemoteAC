import SwiftUI

struct AppView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SplashView()
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        router.showOnboarding()
                    }
                }
                .navigationDestination(for: Screen.self) { item in
                    switch item {
                    case .onboarding:
                        OnboardingView()
                    case .home:
                        HomeView()
                    case .offer(let type):
                        OfferView(viewModel: .init(showType: type))
                    case .settings:
                        SettingsView()
                    default: SplashView()
                    }
                }
        }
    }
}
