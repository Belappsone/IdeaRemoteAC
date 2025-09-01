import SwiftUI

@main
struct Remote_ACApp: App {
    
    @StateObject var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(router)
        }
    }
}
