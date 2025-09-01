import SwiftUI

final class SearchViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showInfo = false
    @Published var showLoading = true
    @Published var model: [SearchItemModel] = []
    @Published var editingModel: [SearchItemModel] = []
    @Published var selectedItem: SearchItemModel? {
        didSet {
            if selectedItem != nil {
                editingModel = model.filter { $0.name != selectedItem?.name ?? "" }
            }
        }
    }
    
    // MARK: Methods
    
    func searchItems() {
        showLoading.toggle()
        model.append(SearchItemModel(name: "LG"))
        model.append(SearchItemModel(name: "Samsung"))
        model.append(SearchItemModel(name: "Huawei"))
        model.append(SearchItemModel(name: "PHP"))
    }
}
