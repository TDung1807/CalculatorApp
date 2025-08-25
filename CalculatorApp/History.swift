import Foundation

struct HistoryItem: Identifiable {
    let id = UUID()
    let expression: String
    let result: String
    let date: Date = Date()
}
