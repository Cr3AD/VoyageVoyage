//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let weatherJSON = try? newJSONDecoder().decode(WeatherJSON.self, from: jsonData)
//
//import Foundation
//
//// MARK: - WeatherJSON
//struct WeatherJSON: Codable {
//    let name: String
//    let wind: Wind
//    let clouds: Clouds
//    let cod: Int
//    let sys: Sys
//    let base: String
//    let timezone, dt, visibility: Int
//    let main: Main
//    let coord: Coord
//    let id: Int
//    let weather: [Weather]
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lat, lon: Double
//}
//
//// MARK: - Main
//struct Main: Codable {
//    let tempMin, tempMax: Double
//    let pressure: Int
//    let temp: Double
//    let humidity: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//        case pressure, temp, humidity
//    }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let type, sunrise, sunset: Int
//    let country: String
//    let id: Int
//    let message: Double
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let main, weatherDescription, icon: String
//    let id: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case main
//        case weatherDescription = "description"
//        case icon, id
//    }
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let deg, speed: Double
//}
