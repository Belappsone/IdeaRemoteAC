import Foundation

struct SearchItemModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var selected: Bool = false
}
