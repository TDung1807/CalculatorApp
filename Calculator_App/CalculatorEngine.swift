import Foundation

enum Op { case add, sub, mul, div }

final class CalculatorEngine {
    // UI đọc chuỗi này
    private(set) var display: String = ""

    // Trạng thái tính toán
    private var current: Decimal = 0            // số đang nhập
    private var accumulator: Decimal? = nil     // lhs
    private var pending: Op? = nil              // phép chờ
    private var lastRHS: Decimal? = nil         // để lặp "="
    private var typing = false                  // đang nhập số?

    // Snapshot lần tính gần nhất cho history
    private(set) var lastSnapshot: (lhs: Decimal, op: Op, rhs: Decimal, result: Decimal)?

    private let fmt: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.maximumFractionDigits = 12
        f.usesGroupingSeparator = false
        return f
    }()

    // MARK: Input
    func inputDigit(_ d: Int) {
        if typing {
            display = (display == "") ? "\(d)" : display + "\(d)"
        } else {
            display = "\(d)"; typing = true
        }
        current = Decimal(string: display) ?? 0
    }

    func inputDot() {
        if !display.contains(".") {
            display = typing ? display + "." : "0."
            typing = true
        }
    }

    func toggleSign() {
        current *= -1
        display = str(current)
    }

    // iOS-like percent
    func percent() {
        if let lhs = accumulator, pending != nil {
            let rhs = current
            current = lhs * rhs / 100
        } else {
            current = current / 100
        }
        display = str(current)
    }

    func clear(all: Bool) {
        if all {
            display = ""; current = 0
            accumulator = nil; pending = nil
            lastRHS = nil; typing = false
            lastSnapshot = nil
        } else {
            display = ""; current = 0; typing = false
        }
    }
    
    func backspace() {
        guard !display.isEmpty else { return }
        if display.count > 1 {
            display.removeLast()
        } else {
            display = ""
        }
        current = Decimal(string: display) ?? 0
    
    }

    func setOp(_ op: Op) {
        commitPendingIfNeeded()
        pending = op
        accumulator = current
        typing = false
    }

    func equals() {
        guard let op = pending else { return }
        let rhs: Decimal
        if typing { rhs = current; lastRHS = rhs }
        else if let last = lastRHS { rhs = last }
        else { rhs = accumulator ?? current }

        let lhs = accumulator ?? 0
        let res = calc(lhs, rhs, op)

        current = res
        display = str(res)
        accumulator = res
        typing = false

        // Lưu cho history
        lastSnapshot = (lhs, op, rhs, res)
    }

    // MARK: Helpers
    private func commitPendingIfNeeded() {
        if let op = pending, let lhs = accumulator, typing {
            let res = calc(lhs, current, op)
            current = res
            display = str(res)
            accumulator = res
            typing = false
        }
    }

    private func calc(_ a: Decimal, _ b: Decimal, _ op: Op) -> Decimal {
        switch op {
        case .add: return a + b
        case .sub: return a - b
        case .mul: return a * b
        case .div: return b == 0 ? 0 : a / b
        }
    }

    private func str(_ d: Decimal) -> String {
        fmt.string(from: d as NSDecimalNumber) ?? "0"
    }

    // Xuất chuỗi biểu thức và kết quả để ViewModel ghi history
    func lastExpressionString(formatter: NumberFormatter) -> (expr: String, res: String)? {
        guard let s = lastSnapshot else { return nil }
        let sym: String = { switch s.op { case .add: return "+"; case .sub: return "−"; case .mul: return "×"; case .div: return "÷" } }()
        let lhs = formatter.string(from: s.lhs as NSDecimalNumber) ?? "0"
        let rhs = formatter.string(from: s.rhs as NSDecimalNumber) ?? "0"
        let res = formatter.string(from: s.result as NSDecimalNumber) ?? "0"
        return ("\(lhs) \(sym) \(rhs)", res)
    }
}
