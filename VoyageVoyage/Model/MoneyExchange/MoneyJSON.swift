// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let moneyRateJSON = try? newJSONDecoder().decode(MoneyRateJSON.self, from: jsonData)

import Foundation

// MARK: - MoneyRateJSON
public struct MoneyJSON: Codable {
    public let base: String
    public let date: String
    public var rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case base
        case date
        case rates
    }
    
    public init(base: String, date: String, rates: [String: Double]) {
        self.base = base
        self.date = date
        self.rates = rates
    }
}
