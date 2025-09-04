import SwiftUI

struct AppView: View {
    
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            SplashView()
                .onAppear() {
                    Task {
                        let openAppManager = AdMobOpenAppManager.shared
                        
                        await AdaptyManager.shared.configure()
                        await AdaptyManager.shared.checkSubscription()
                        await openAppManager.configure()
                        
                        if AppCache.showOffer && !AdaptyManager.isSubscribeAdaptyActive {
                            AppCache.showOffer = false
                            router.showOffer(type: .push)
                        } else if AppCache.countLaunch == 1 {
                            router.showOnboarding()
                        } else {
                            if AdaptyManager.isSubscribeAdaptyActive {
                                router.showMain()
                            } else {
                                if openAppManager.isReady {
                                    AdMobOpenAppManager.shared.completionResult = {
                                        router.showPaywall(type: .onboarding)
                                    }
                                    AdMobOpenAppManager.shared.showOpenApp()
                                } else {
                                    router.showPaywall(type: .onboarding)
                                }
                            }
                        }
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
                    case .superOffer:
                        OfferView(viewModel: .init(showType: .paywall, placement: .superoffer))
                    case .settings:
                        SettingsView()
                    case .search:
                        SearchView()
                    case .paywall(let type):
                        switch AdaptyPlacment.mainPlacementIs {
                        case .simplecomment:
                            SimpleCommentView(viewModel: .init(showType: type))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(4)
                        case .checkbox:
                            CheckBoxView(viewModel: .init(showType: type))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(4)
                        case .simple:
                            SimpleView(viewModel: .init(showType: type))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(4)
                        case .switcher:
                            SwitcherView(viewModel: .init(showType: type))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(4)
                        default:
                            MainView(viewModel: .init(showType: type))
                                .frame(width: UIScreen.main.bounds.width)
                                .id(4)
                        }
                    default: SplashView()
                    }
                }
        }
    }
}
