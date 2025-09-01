import SwiftUI

enum SFProDisplay: String {
    case heavy = "SFProDisplay-Heavy"
    case bold = "SFProDisplay-Bold"
}

extension Font {
    static func sfProDisplay(weight: SFProDisplay, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}
