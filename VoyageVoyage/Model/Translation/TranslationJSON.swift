// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tradJson = try? newJSONDecoder().decode(TradJson.self, from: jsonData)

import Foundation

// MARK: - TradJson
struct TranslationJSON: Codable {
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]?
    
    enum CodingKeys: String, CodingKey {
        case translations
    }
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String?
    
    enum CodingKeys: String, CodingKey {
        case translatedText
    }
}
