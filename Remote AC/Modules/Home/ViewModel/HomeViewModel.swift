import SwiftUI

final class HomeViewModel: ObservableObject {
    // MARK: Properies
    
    @Published var fanSpeedIndexSelected: Int? = nil
    @Published var temperatureIndexSelected: Int? = nil
}
