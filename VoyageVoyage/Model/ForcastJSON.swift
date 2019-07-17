//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let forcastJSON = try? newJSONDecoder().decode(ForcastJSON.self, from: jsonData)
//
//import Foundation
//
//// MARK: - ForcastJSON
//struct ForcastJSON: Codable {
//    let list: [List]
//    let cnt: Int
//    let message: Double
//    let city: City
//    let cod: String
//}
//
//// MARK: - City
//struct City: Codable {
//    let population: Int
//    let country, name: String
//    let timezone, id: Int
//    let coord: Coord
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double
//}
//
//// MARK: - List
//struct List: Codable {
//    let main: Main
//    let wind: Wind
//    let dt: Int
//    let clouds: Clouds
//    let dtTxt: String
//    let weather: [Weather]
//    let sys: Sys
//    
//    enum CodingKeys: String, CodingKey {
//        case main, wind, dt, clouds
//        case dtTxt = "dt_txt"
//        case weather, sys
//    }
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - Main
//struct Main: Codable {
//    let grndLevel, pressure, tempKf, tempMax: Double
//    let humidity: Int
//    let temp, tempMin, seaLevel: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case grndLevel = "grnd_level"
//        case pressure
//        case tempKf = "temp_kf"
//        case tempMax = "temp_max"
//        case humidity, temp
//        case tempMin = "temp_min"
//        case seaLevel = "sea_level"
//    }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let pod: String
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let icon, weatherDescription, main: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id, icon
//        case weatherDescription = "description"
//        case main
//    }
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed, deg: Double
//}
