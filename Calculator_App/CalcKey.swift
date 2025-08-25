import Foundation

enum CalcKey: Hashable {
    case ac, clear, plusMinus, percent
    case divide, multiply, minus, plus
    case equals, dot
    case digit(Int)
    case backspace
}

extension CalcKey {
    var title: String {
        switch self {
        case .digit(let n): return String(n)
        case .dot: return "."
        case .plus: return "+"
        case .minus: return "−"
        case .multiply: return "×"
        case .divide: return "÷"
        case .equals: return "="
        case .percent: return "%"
        case .plusMinus: return "±"
        case .ac: return "AC"
        case .clear: return "C"
        case .backspace: return "⌫"
        }
    }
    var isOp: Bool { [.plus,.minus,.multiply,.divide].contains(self) }
    var isUtility: Bool { [.ac,.clear,.plusMinus,.percent].contains(self) }
}
