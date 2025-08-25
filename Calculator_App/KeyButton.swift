import SwiftUI

enum KeyVisual { case primary, utility, op, equals, destructive }

struct KeyButton: View {
    let key: CalcKey
    let visual: KeyVisual
    let action: () -> Void

    init(_ key: CalcKey, visual: KeyVisual, action: @escaping () -> Void) {
        self.key = key
        self.visual = visual
        self.action = action
    }

    var body: some View {
        Button {
            Haptics.heavy()
            action()
        } label: {
            Text(key.title)
                .font(.system(size: 26, weight: .semibold, design: .rounded))
                .foregroundStyle(fg)
                .frame(maxWidth: .infinity, minHeight: Tokens.keyMinH)
                .background(bg)
                .clipShape(RoundedRectangle(cornerRadius: Tokens.corner, style: .continuous))
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }

    private var bg: Color {
        switch visual {
        case .primary:     return .keyPrimary
        case .utility:     return .keyUtility
        case .op:          return .keyOp
        case .equals:      return .keyEquals
        case .destructive: return .keyDestructive
        }
    }
    private var fg: Color {
        switch visual {
        case .primary:     return .textOnDark
        case .utility:     return .white
        case .op:          return .white
        case .equals:      return .white
        case .destructive: return .white
        }
    }
}
