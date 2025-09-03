import Foundation
import AppTrackingTransparency

final class AttManager {
    static let shared = AttManager()
    
    private init() {}
    
    func config() {
        ATTrackingManager.requestTrackingAuthorization { state in print(state) }
    }
}
