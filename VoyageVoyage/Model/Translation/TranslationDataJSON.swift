// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let translateDataJSON = try? newJSONDecoder().decode(TranslateDataJSON.self, from: jsonData)

import Foundation

// MARK: - TranslateDataJSON
struct TranslationDataJSON: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText, detectedSourceLanguage: String?
}
