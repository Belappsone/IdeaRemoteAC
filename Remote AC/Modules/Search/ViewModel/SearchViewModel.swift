import SwiftUI

final class SearchViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var showError = false
    @Published var showInfo = false
    @Published var showLoading = true
    @Published var model: [SearchItemModel] = []
    @Published var editingModel: [SearchItemModel] = []
    @Published var selectedItem: SearchItemModel? {
        didSet {
            if selectedItem != nil {
                editingModel = model.filter { $0.name != selectedItem?.name ?? "" }
                
                if AppCache.selectedItems.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.scanner.stop()
                        AppCache.selectedItem = self.selectedItem
                        AppCache.selectedItems = self.editingModel
                        self.closeSearch?()
                    }
                }
            }
        }
    }
    @Published var currentTime: Int = .zero
    
    var errorModelIndex: Int = .zero
    var errorModel: ErrorsSheetModel { ErrorsSheetModel.defaultModel[errorModelIndex] }
    
    var wifiName: String = AdaptyManager.getGlobalRemoteSettings(key: .wifiName)
    private var showWifiName: Bool = AdaptyManager.getGlobalRemoteSettings(key: .showWifiName)
    private var flag = true
    private lazy var scanner = LanScanner(delegate: self)
    
    var closeSearch: (() -> Void)?
    
    // MARK: Init
        
    // MARK: Methods
    
    func searchItems() {
        if AppCache.selectedItems.isEmpty {
            scanner.start()
            startTimer()
        } else {
            selectedItem = AppCache.selectedItem
            editingModel = AppCache.selectedItems
            model = AppCache.selectedItems
            if let item = AppCache.selectedItem {
                model.insert(item, at: 0)
            }
            showLoading = false
        }
    }
    
    func retrySearch() {
        model.removeAll()
        editingModel.removeAll()
        selectedItem = nil
        AppCache.selectedItem = nil
        AppCache.selectedItems = []
        
        currentTime = .zero
        showLoading = true
        flag = true
        scanner.start()
        startTimer()
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
            self.currentTime += 1
            
            if self.currentTime >= 99 {
                timer.invalidate()
            }
        })
    }
}

extension SearchViewModel: LanScannerDelegate {
    func lanScanHasUpdatedProgress(_ progress: CGFloat, address: String) {
        if showWifiName {
            if flag {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    let local = SearchItemModel(name: self.wifiName)
                    self.model.insert(local, at: 0)
                    self.showLoading = false
                }
                flag = false
            }
        } else {
            if progress >= 0.3 {
                if !model.isEmpty {
                    showLoading = false
                } else {
                    errorModelIndex = Int.random(in: 0..<ErrorsSheetModel.defaultModel.count)
                    showError = true
                }
            }
            
        }
        
    }

    func lanScanDidFindNewDevice(_ device: LanDevice) {
        let local = SearchItemModel(name: device.name)
        model.append(local)
    }

    func lanScanDidFinishScanning() {}
}
