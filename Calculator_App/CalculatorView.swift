import SwiftUI

struct CalculatorView: View {
    @StateObject var vm = CalculatorViewModel()
    private let cols = Array(repeating: GridItem(.flexible(), spacing: Tokens.gap), count: 4)

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBG.ignoresSafeArea()

            // Nút history góc phải trên
            VStack {
                HStack {
                    Spacer()
                    Button {
                        Haptics.heavy()
                        vm.showingHistory = true
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 20, weight: .semibold))
                            .padding(10)
                            .background(Color.black.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                ResultPlate(text: vm.display)
                        .padding(.top, 250) // đẩy xuống cách top 120
                    Spacer()
                }
            .sheet(isPresented: $vm.showingHistory) {
                HistoryView(items: $vm.history)
            }

            // Keypad
            VStack(spacing: Tokens.gap) {
                LazyVGrid(columns: cols, spacing: Tokens.gap) {
                    // Hàng 1
                    key(.ac, visual: .destructive)
                    key(.plusMinus, visual: .utility)
                    key(.percent, visual: .utility)
                    key(.divide, visual: .op)
                    // Hàng 2
                    key(.digit(7), visual: .primary)
                    key(.digit(8), visual: .primary)
                    key(.digit(9), visual: .primary)
                    key(.multiply, visual: .op)
                    // Hàng 3
                    key(.digit(4), visual: .primary)
                    key(.digit(5), visual: .primary)
                    key(.digit(6), visual: .primary)
                    key(.minus, visual: .op)
                    // Hàng 4
                    key(.digit(1), visual: .primary)
                    key(.digit(2), visual: .primary)
                    key(.digit(3), visual: .primary)
                    key(.plus, visual: .op)
                    // Hàng 5
                    key(.backspace, visual: .utility)
                    KeyButton(.digit(0), visual: .primary) { vm.tap(.digit(0)) }
                        .gridCellColumns(2)
                    key(.dot, visual: .primary)
                    key(.equals, visual: .equals)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
    }

    @ViewBuilder
    private func key(_ k: CalcKey, visual: KeyVisual) -> some View {
        KeyButton(k, visual: visual) { vm.tap(k) }
    }
}
