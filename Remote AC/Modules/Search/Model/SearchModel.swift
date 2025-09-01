import Foundation

struct SearchItemModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var selected: Bool = false
}
