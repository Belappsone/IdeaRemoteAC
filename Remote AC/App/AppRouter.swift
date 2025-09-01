import SwiftUI

final class AppRouter: ObservableObject {
    // MARK: Propeties
    
    @Published var path: [Screen] = []
    
    // MARK: Methods
    
    func showOnboarding() {
        path.append(.onboarding)
    }
    
    func showMain() {
        path.append(.home)
    }
    
    func showOffer(type: OfferType) {
        path.append(.offer(type: type))
    }
    
    func showSettings() {
        path.append(.settings)
    }
    
    func pop() {
        path.removeLast()
    }
}

enum Screen: Hashable {
    case splash
    case onboarding
    case home
    case offer(type: OfferType)
    case settings
}
