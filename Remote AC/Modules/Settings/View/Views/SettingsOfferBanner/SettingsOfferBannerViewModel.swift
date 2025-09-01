import SwiftUI

final class SettingsOfferBannerViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var min: String = "03"
    @Published var sec: String = "00"
    
    private var timer: Timer?
    private var currentTime: Int = 900
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerTrigger), userInfo: nil, repeats: true)
    }
    
    private func convertSecondsToMinutesAndSeconds(seconds: Int) {
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        
        self.min = String(format: "%02d", minutes)
        self.sec = String(format: "%02d", remainingSeconds)
    }
}

// MARK: - TimerSubscription
private extension SettingsOfferBannerViewModel {
    @objc func timerTrigger() {
        if currentTime <= 0 {
            currentTime = 900
        } else {
            currentTime -= 1
            convertSecondsToMinutesAndSeconds(seconds: currentTime)
        }
    }
}
