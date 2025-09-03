import UIKit

final class NotificationManager {
    static let shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}
    
    func setupNotifications() {
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func addNotification() {
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let notificationContent = UNMutableNotificationContent()
                notificationContent.body = "Special offer for you! Best price! Only right now!".localizable
                let date = Date().addingTimeInterval(3)
                let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString,
                                                    content: notificationContent,
                                                    trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}
