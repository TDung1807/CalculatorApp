import SwiftUI

struct HistoryView: View {
    @Binding var items: [HistoryItem]
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirm = false //confirmation popup

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Thanh top bar
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Button("Done") { dismiss() }
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .semibold))

                        Spacer()

                        Button("Clear", role: .destructive) {
                            showConfirm = true
                        }
                        .foregroundColor(.red)
                        .font(.system(size: 18, weight: .regular))
                    }

                    Text("History")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top,20)
                }
                .padding()
                .background(Color.black)

                // Danh sách lịch sử
                List {
                    ForEach(items) { it in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(it.expression)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text(it.result)
                                .font(.title3).bold()
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Color.black)
                    }
                    .onDelete { items.remove(atOffsets: $0) }
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
                .background(Color.black)
            }
            .background(Color.black.ignoresSafeArea())
            .alert("Clear history?", isPresented: $showConfirm) {
                            Button("Cancel", role: .cancel) { }
                            Button("Clear", role: .destructive) {
                                items.removeAll()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                                dismiss()
                            }
                        } message: {
                            Text("This will remove all history items.")
                        }
        }
        .navigationBarHidden(true)
            }
}
