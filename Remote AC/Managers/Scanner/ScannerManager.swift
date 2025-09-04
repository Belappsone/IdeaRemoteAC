import Foundation
import Network

final class ScannerManager: NSObject, NetServiceBrowserDelegate {
    static let shared = ScannerManager()
    
    override private init() {}
    
    private var browser: NetServiceBrowser?

    func startBrowsing() {
        browser = NetServiceBrowser()
        browser?.delegate = self
        browser?.searchForServices(ofType: "_http._tcp.", inDomain: "local.")
    }

    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("Обнаружен сервис: \(service.name)")
    }
}
