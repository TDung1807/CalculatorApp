import UIKit

enum Haptics {
    static func heavy() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
