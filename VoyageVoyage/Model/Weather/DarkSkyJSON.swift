// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let darkSkyJson = try? newJSONDecoder().decode(DarkSkyJSON.self, from: jsonData)

import Foundation

// MARK: - DarkSkyJson
struct DarkSkyJson: Codable {
    let latitude: Double?
    let longitude: Double?
    let timezone: String?
    let currently: Currently?
    let minutely: Minutely?
    let hourly: Hourly?
    let daily: Daily?
    let flags: Flags?
    let offset: Int?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case flags
        case offset
    }
}

// MARK: - Currently
struct Currently: Codable {
    let time: Int?
    let summary: Summary?
    let icon: Icon?
    let nearestStormDistance: Int?
    let nearestStormBearing: Int?
    let precipIntensity: Int?
    let precipProbability: Int?
    let temperature: Double?
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility: Double?
    let ozone: Double?
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case nearestStormDistance
        case nearestStormBearing
        case precipIntensity
        case precipProbability
        case temperature
        case apparentTemperature
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windBearing
        case cloudCover
        case uvIndex
        case visibility
        case ozone
    }
}

enum Icon: String, Codable {
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}

enum Summary: String, Codable {
    case mostlyCloudy = "Mostly Cloudy"
    case partlyCloudy = "Partly Cloudy"
}

// MARK: - Daily
struct Daily: Codable {
    let summary: String?
    let icon: String?
    let data: [DailyDatum]?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}

// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let sunriseTime: Int?
    let sunsetTime: Int?
    let moonPhase: Double?
    let precipIntensity: Double?
    let precipIntensityMax: Double?
    let precipIntensityMaxTime: Int?
    let precipProbability: Double?
    let precipType: PrecipType?
    let temperatureHigh: Double?
    let temperatureHighTime: Int?
    let temperatureLow: Double?
    let temperatureLowTime: Int?
    let apparentTemperatureHigh: Double?
    let apparentTemperatureHighTime: Int?
    let apparentTemperatureLow: Double?
    let apparentTemperatureLowTime: Int?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windGustTime: Int?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let uvIndexTime: Int?
    let visibility: Double?
    let ozone: Double?
    let temperatureMin: Double?
    let temperatureMinTime: Int?
    let temperatureMax: Double?
    let temperatureMaxTime: Int?
    let apparentTemperatureMin: Double?
    let apparentTemperatureMinTime: Int?
    let apparentTemperatureMax: Double?
    let apparentTemperatureMaxTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case sunriseTime
        case sunsetTime
        case moonPhase
        case precipIntensity
        case precipIntensityMax
        case precipIntensityMaxTime
        case precipProbability
        case precipType
        case temperatureHigh
        case temperatureHighTime
        case temperatureLow
        case temperatureLowTime
        case apparentTemperatureHigh
        case apparentTemperatureHighTime
        case apparentTemperatureLow
        case apparentTemperatureLowTime
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windGustTime
        case windBearing
        case cloudCover
        case uvIndex
        case uvIndexTime
        case visibility
        case ozone
        case temperatureMin
        case temperatureMinTime
        case temperatureMax
        case temperatureMaxTime
        case apparentTemperatureMin
        case apparentTemperatureMinTime
        case apparentTemperatureMax
        case apparentTemperatureMaxTime
    }
}

enum PrecipType: String, Codable {
    case rain = "rain"
}

// MARK: - Flags
struct Flags: Codable {
    let sources: [String]?
    let nearestStation: Double?
    let units: String?
    
    enum CodingKeys: String, CodingKey {
        case sources
        case nearestStation
        case units
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let summary: String?
    let icon: Icon?
    let data: [HourlyDatum]?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}

// MARK: - HourlyDatum
struct HourlyDatum: Codable {
    let time: Int?
    let summary: Summary?
    let icon: Icon?
    let precipIntensity: Double?
    let precipProbability: Double?
    let temperature: Double?
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let windGust: Double?
    let windBearing: Int?
    let cloudCover: Double?
    let uvIndex: Int?
    let visibility: Double?
    let ozone: Double?
    let precipType: PrecipType?
    
    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case precipIntensity
        case precipProbability
        case temperature
        case apparentTemperature
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windBearing
        case cloudCover
        case uvIndex
        case visibility
        case ozone
        case precipType
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    let summary: String?
    let icon: Icon?
    let data: [MinutelyDatum]?
    
    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}

// MARK: - MinutelyDatum
struct MinutelyDatum: Codable {
    let time: Int?
    let precipIntensity: Int?
    let precipProbability: Int?
    
    enum CodingKeys: String, CodingKey {
        case time
        case precipIntensity
        case precipProbability
    }
}
