import SwiftUI

final class MainViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
    @Published var selectedProduct: Int = 0
}
