import SwiftUI

struct HistoryView: View {
    @Binding var items: [HistoryItem]
    @Environment(\.dismiss) private var dismiss

    @State private var showConfirm = false
    @State private var showBanner = false
    @State private var bannerText = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top bar: Done + Clear
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
                        .padding(.top, 20)
                }
                .padding()
                .background(Color.black)

                // List
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
            // Alert xác nhận
            .alert("Clear history?", isPresented: $showConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    let n = items.count
                    items.removeAll()
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    

                    bannerText = "Đã xoá \(n) phép tính"
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                        showBanner = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.3)) { showBanner = false }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { dismiss() }
                    }
                }
            } message: {
                Text("This will remove all history items.")
            }
            // Banner thông báo
            .overlay(alignment: .top) {
                if showBanner {
                    Text(bannerText)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 17)
                        .padding(.vertical, 13)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.top, 8)
                        .shadow(radius: 8, y: 6)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
        }
        .navigationBarHidden(true)
    }
}
