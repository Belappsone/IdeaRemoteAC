import SwiftUI

final class SwitcherViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
    @Published var isOn = false
}
