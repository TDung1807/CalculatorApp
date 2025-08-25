import SwiftUI


final class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var history: [HistoryItem] = []
    @Published var showingHistory = false

    private let engine = CalculatorEngine()

    // Formatter dùng chung để format số trong history
    private let fmt: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 12
        f.usesGroupingSeparator = false
        return f
    }()

    var clearKey: CalcKey { display == "0" ? .ac : .clear }

    init() { display = engine.display }

    func tap(_ k: CalcKey) {
        switch k {
        case .digit(let n): engine.inputDigit(n)
        case .dot: engine.inputDot()
        case .plusMinus: engine.toggleSign()
        case .percent: engine.percent()
        case .divide: engine.setOp(.div)
        case .multiply: engine.setOp(.mul)
        case .minus: engine.setOp(.sub)
        case .plus: engine.setOp(.add)
        case .equals:
            engine.equals()
            if let s = engine.lastExpressionString(formatter: fmt) {
                history.insert(HistoryItem(expression: s.expr, result: s.res), at: 0)
            }
        case .ac: engine.clear(all: true)
        case .clear: engine.clear(all: false)
        }
        display = engine.display
    }
}
