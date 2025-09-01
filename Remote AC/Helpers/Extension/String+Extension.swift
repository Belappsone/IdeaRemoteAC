import Foundation

extension String {
    var localizable: String { NSLocalizedString(self, comment: "") }
}
