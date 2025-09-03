import Foundation

enum AppConfig {
    static let terms: String = AdaptyManager.getGlobalRemoteSettings(key: .termsUrl)
    static let privacy: String = AdaptyManager.getGlobalRemoteSettings(key: .privacyUrl)
    
    static let adaptyKey = "public_live_0U0xUOfo.uq6K5acSTOCO6ebSnsZr"
    
#if DEBUG
    static let adOpenApp = "ca-app-pub-6868541782864965/7085627336"
    static let adInterstial = "ca-app-pub-6868541782864965/3609416759"
#else
    static let adOpenApp = "ca-app-pub-6868541782864965/3795561110"
    static let adInterstial = "ca-app-pub-6868541782864965/5596847501"
#endif
    
    static let adInfo = "ca-app-pub-6868541782864965~3356784242"
}
