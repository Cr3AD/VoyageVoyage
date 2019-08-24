// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forcastDataJSON = try? newJSONDecoder().decode(ForcastDataJSON.self, from: jsonData)

import Foundation

// MARK: - ForcastDataJSON
struct ForcastDataJSON: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [ForcastList]?
    let city: ForcastCity?
}

// MARK: - ForcastCity
struct ForcastCity: Codable {
    let id: Int?
    let name: String?
    let coord: ForcastCoord?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - ForcastCoord
struct ForcastCoord: Codable {
}

// MARK: - ForcastList
struct ForcastList: Codable {
    let dt: Int?
    let main: ForcastMainClass?
    let weather: [ForcastWeather]?
    let clouds: ForcastClouds?
    let wind: ForcastWind?
    let rain: ForcastRain?
    let sys: ForcastSys?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - ForcastClouds
struct ForcastClouds: Codable {
    let all: Int?
}

// MARK: - ForcastMainClass
struct ForcastMainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double?
    let seaLevel, grndLevel: Double?
    let humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - ForcastRain
struct ForcastRain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - ForcastSys
struct ForcastSys: Codable {
    let pod: ForcastPod?
}

enum ForcastPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - ForcastWeather
struct ForcastWeather: Codable {
    let id: Int?
    let main: ForcastMainEnum?
    let weatherDescription: ForcastDescription?
    let icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum ForcastMainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum ForcastDescription: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - ForcastWind
struct ForcastWind: Codable {
    let speed, deg: Double?
}
