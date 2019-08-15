

// MARK: - MoneyRate
struct MoneyDataJSON: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    var rates: [String: Double]
}
