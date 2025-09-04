import UIKit

final class ContactSupport {
    static let shared = ContactSupport()
    
    private init() {}
    
    func openMailToContactUs() {
        let supportEmail: String = AdaptyManager.getGlobalRemoteSettings(key: .supportEmail)
        let contactURL = supportEmail
        let letterSubject = "Feedback"
        var appVersion = "\nApp version: "
        if let versionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            appVersion += "\(versionString)"
        }
        if let buildString = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
            appVersion += "(\(buildString))"
        }
        let iosVersion = "\niOS version: \(UIDevice.current.systemVersion)"
        let body = appVersion + iosVersion
        
        let mailString = "mailto:" + contactURL + "?subject=" + letterSubject + "&body=" + body
        var finishString = mailString.replacingOccurrences(of: " ", with: "%20")
        finishString = finishString.replacingOccurrences(of: "\n", with: "%0A")
        if let mailUrl = URL(string: finishString) {
            UIApplication.shared.open(mailUrl, options: [:])
        }
    }
}

