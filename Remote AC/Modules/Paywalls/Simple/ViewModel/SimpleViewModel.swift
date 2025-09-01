import SwiftUI

final class SimpleViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
}
