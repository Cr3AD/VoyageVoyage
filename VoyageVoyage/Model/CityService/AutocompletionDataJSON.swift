// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let autoCompletionDataJSON = try? newJSONDecoder().decode(AutoCompletionDataJSON.self, from: jsonData)

import Foundation

// MARK: - AutoCompletionDataJSON
struct AutoCompletionDataJSON: Codable {
    let predictions: [AutoCompletionPrediction]?
    let status: String?
}

// MARK: - AutoCompletionPrediction
struct AutoCompletionPrediction: Codable {
    let predictionDescription, id: String?
    let matchedSubstrings: [AutoCompletionMatchedSubstring]?
    let placeID, reference: String?
    let structuredFormatting: AutoCompletionStructuredFormatting?
    let terms: [AutoCompletionTerm]?
    let types: [String]?
    
    enum CodingKeys: String, CodingKey {
        case predictionDescription = "description"
        case id
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }
}

// MARK: - AutoCompletionMatchedSubstring
struct AutoCompletionMatchedSubstring: Codable {
    let length, offset: Int?
}

// MARK: - AutoCompletionStructuredFormatting
struct AutoCompletionStructuredFormatting: Codable {
    let mainText: String?
    let mainTextMatchedSubstrings: [AutoCompletionMatchedSubstring]?
    let secondaryText: String?
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
}

// MARK: - AutoCompletionTerm
struct AutoCompletionTerm: Codable {
    let offset: Int?
    let value: String?
}
