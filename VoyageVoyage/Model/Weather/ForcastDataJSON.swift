// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forcastForcastJson = try? newJSONDecoder().decode(forcastForcastJson.self, from: jsonData)


import Foundation

// MARK: - forcastForcastJson
struct ForcastDataJSON: Codable {
    let list: [forcastList]?
    let cnt: Int?
    let message: Double?
    let city: forcastCity?
    let cod: String?
    
    enum CodingKeys: String, CodingKey {
        case list
        case cnt
        case message
        case city
        case cod
    }
}

// MARK: - forcastCity
struct forcastCity: Codable {
    let population: Int?
    let country: String?
    let name: String?
    let timezone: Int?
    let id: Int?
    let coord: forcastCoord?
    
    enum CodingKeys: String, CodingKey {
        case population
        case country
        case name
        case timezone
        case id
        case coord
    }
}

// MARK: - forcastCoord
struct forcastCoord: Codable {
    let lat: Double?
    let lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}

// MARK: - forcastList
struct forcastList: Codable {
    let main: forcastMain?
    let wind: forcastWind?
    let dt: Int?
    let clouds: forcastClouds?
    let dtTxt: String?
    let weather: [forcastWeather]?
    let sys: forcastSys?
    
    enum CodingKeys: String, CodingKey {
        case main
        case wind
        case dt
        case clouds
        case dtTxt
        case weather
        case sys
    }
}

// MARK: - forcastClouds
struct forcastClouds: Codable {
    let all: Int?
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

// MARK: - forcastMain
struct forcastMain: Codable {
    let grndLevel: Double?
    let pressure: Double?
    let tempKf: Double?
    let tempMax: Double?
    let humidity: Int?
    let temp: Double?
    let tempMin: Double?
    let seaLevel: Double?
    
    enum CodingKeys: String, CodingKey {
        case grndLevel
        case pressure
        case tempKf
        case tempMax
        case humidity
        case temp
        case tempMin
        case seaLevel
    }
}

// MARK: - forcastSys
struct forcastSys: Codable {
    let pod: String?
    
    enum CodingKeys: String, CodingKey {
        case pod
    }
}

// MARK: - forcastWeather
struct forcastWeather: Codable {
    let id: Int?
    let icon: String?
    let weatherDescription: String?
    let main: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case icon
        case weatherDescription
        case main
    }
}

// MARK: - forcastWind
struct forcastWind: Codable {
    let speed: Double?
    let deg: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
}

