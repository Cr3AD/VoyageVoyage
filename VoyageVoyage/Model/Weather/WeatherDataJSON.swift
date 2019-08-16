
import Foundation

// MARK: - WeatherJson
struct WeatherDataJSON: Codable {
    let wind: Wind?
    let cod: Int?
    let dt: Int?
    let visibility: Int?
    let id: Int?
    let clouds: Clouds?
    let coord: Coord?
    let name: String?
    let weather: [Weather]?
    let main: Main?
    let base: String?
    let timezone: Int?
    let sys: Sys?
    
    enum CodingKeys: String, CodingKey {
        case wind
        case cod
        case dt
        case visibility
        case id
        case clouds
        case coord
        case name
        case weather
        case main
        case base
        case timezone
        case sys
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lat: Double?
    let lon: Double?
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }
}

// MARK: - Main
struct Main: Codable {
    let tempMin: Double?
    let humidity: Int?
    let temp: Double?
    let tempMax: Double?
    let pressure: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case humidity
        case temp
        case tempMax = "temp_max"
        case pressure
    }
}

// MARK: - Sys
struct Sys: Codable {
    let message: Double?
    let type: Int?
    let country: String?
    let id: Int?
    let sunrise: Int?
    let sunset: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case type
        case country
        case id
        case sunrise
        case sunset
    }
}

// MARK: - Weather
struct Weather: Codable {
    let main: String?
    let icon: String?
    let id: Int?
    let weatherDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case main
        case icon
        case id
        case weatherDescription = "description"
    }
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Double?
    let speed: Double?
    
    enum CodingKeys: String, CodingKey {
        case deg
        case speed
    }
}

