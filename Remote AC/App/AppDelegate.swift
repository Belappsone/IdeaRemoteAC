import UIKit
import SkarbSDK
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    var launchFromPush: Bool = false
    var pushPayload: [AnyHashable: Any]?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            if let notification = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
                launchFromPush = true
                pushPayload = notification
            }
            
            NotificationManager.shared.notificationCenter.delegate = self
            NotificationManager.shared.setupNotifications()
            
            AppCache.countLaunch += 1
            
//            FirebaseApp.configure()
            SkarbSDK.initialize(clientId: "Belappsone", isObservable: true)
            AdMobInterstitialManager.shared.configureGoogleAdMob()
            return true
        }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            self.launchFromPush = true
            self.pushPayload = response.notification.request.content.userInfo
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("showPushOffer"), object: nil)
            }
        }
}
