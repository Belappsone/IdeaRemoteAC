import SwiftUI

final class SimpleCommentViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showLoading = false
    @Published var showCancelOffer = false
}
