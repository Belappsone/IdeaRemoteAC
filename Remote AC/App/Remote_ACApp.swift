import SwiftUI

@main
struct Remote_ACApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(router)
                .onAppear {
                    if appDelegate.launchFromPush {
                        appDelegate.launchFromPush = false
                        AppCache.showOffer = true
                    }
                }
        }
        .onChange(of: scenePhase) { newValue, oldValue in
            if oldValue == .background {
                if AppCache.countLaunch == 1 && !AdaptyManager.isSubscribeAdaptyActive {
                    AppCache.countLaunch += 1
                    NotificationManager.shared.addNotification()
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("showPushOffer"),
                                                   object: nil,
                                                   queue: .main) { _ in
                if !AdaptyManager.shared.paywalls.isEmpty {
                    router.showOffer(type: .push)
                } else {
                    AppCache.showOffer = true
                }
            }
        }
    }
}
