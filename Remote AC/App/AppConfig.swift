import Foundation

enum AppConfig {
    static let terms: String = "www.google.com" //AdaptyManager.getGlobalRemoteSettings(key: .termsUrl)
    static let privacy: String = "www.google.com" //AdaptyManager.getGlobalRemoteSettings(key: .privacyUrl)
    
    static let adaptyKey = "public_live_9ZuEF63L.Fuyl0p7tlUXUjB5YyBDG"
    
#if DEBUG
    static let adOpenApp = "ca-app-pub-3940256099942544/5575463023"
    static let adInterstial = "ca-app-pub-3940256099942544/4411468910"
#else
    static let adOpenApp = "ca-app-pub-6868541782864965/3795561110"
    static let adInterstial = "ca-app-pub-6868541782864965/5596847501"
#endif
    
    static let adInfo = "ca-app-pub-6868541782864965~3265078076"
}
