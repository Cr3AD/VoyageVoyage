//
//  WeatherDataModel.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//
import Foundation
import SwiftyJSON


struct Forcast {
    let time: Date
    let hour: String
    let temp: String
    let condition: Int
    let weatherIconName: String
    
}

class WeatherManager {
    
    
    // MARK: - Proprieties
    
    var temperature: String = ""
    var temperatureMin: String = ""
    var temperatureMax: String = ""
    var wind: String = ""
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    var isItDay : Bool = false
    var formatedSunriseDate : String = ""
    var formatedSunsetDate : String = ""
    var weatherDescription = ""
    var weatherHumidity: String = ""
    let currentDateTime = Date()
    
    var forcastArray = [Forcast]()
    
    // Delegate
    
    var weatherDidUpdateDelegate: WeatherDidUpdate?
    var WeatherForcastDidUpdateDelegate: WeatherForcastDidUpdate?
    
    // MARK: - Enums
    
    enum ConnectionError: Error {
        case noConnection
        case delayTooLong
    }
    
    // MARK: - Methodes

    
    // Update weather data
    
    func updateWeaterData(json : JSON) {
        temperature = String("\(Int(json["main"]["temp"].doubleValue - 273.15))°")
        temperatureMin = String("\(Int(json["main"]["temp_min"].doubleValue - 273.15))°")
        temperatureMax = String("\(Int(json["main"]["temp_max"].doubleValue - 273.15))°")
        wind = String("\(Int(json["wind"]["speed"].doubleValue)) km/h")
        city = json["name"].stringValue
        condition = json["weather"][0]["id"].intValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH:mm"
        
        let sunriseDate = Date(timeIntervalSince1970: json["sys"]["sunrise"].doubleValue)
        let sunsetDate = Date(timeIntervalSince1970: json["sys"]["sunset"].doubleValue)
        
        formatedSunsetDate = dateFormatter.string(from: sunsetDate)
        formatedSunriseDate = dateFormatter.string(from: sunriseDate)
        
        
        if currentDateTime > sunriseDate && currentDateTime < sunsetDate {
            isItDay = true
        } else {
            isItDay = false
        }
        weatherIconName = updateWeatherIcon(condition: condition)
        weatherDescription = json["weather"][0]["description"].stringValue
        weatherHumidity = String(json["main"]["humidity"].doubleValue)
        
        
        print("weather data did update")
        weatherDidUpdateDelegate?.updateWeatherDataForcast()
    }
    
    // Update weather data forcast
    
    func updateWeatherDataForcase(json: JSON) {
        
        for result in json["list"].array! {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat  = "HH:mm"
            
            let time = Date(timeIntervalSince1970: result["dt"].doubleValue)
            let hour = dateFormatter.string(from: time).capitalized
            
            let temp = String("\(Int(result["main"]["temp"].doubleValue - 273.15))°")
            let condition = result["weather"][0]["id"].intValue
            let weatherIconName = updateWeatherIcon(condition: condition)
            
            
            let data = Forcast(time : time, hour: hour, temp: temp, condition: condition, weatherIconName: weatherIconName)
            self.forcastArray.append(data)
            
            
            
          
        }
        
        print("weather forcast did update")
        WeatherForcastDidUpdateDelegate?.updateWeatherDataOnScreen()
    }
    
    // Update weather Icons
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 200...300 :
            return "thunderstorm"
        case 301...600 :
            if isItDay == true {
                return "rainday"
            } else {
                return "rainnight"
            }
            
        case 501...600 :
            return "rainnight"
            
        case 601...700 :
            if isItDay == true {
                return "snowday"
            } else {
                return "snownight"
            }
            
        case 701...771 :
            if isItDay == true {
                return "fogday"
            } else {
                return "fognight"
            }
            
        case 781...799 :
            return "wind"
            
        case 800 :
            if isItDay == true {
                return "sunny"
            } else {
                return "moon"
            }
            
        case 801...802 :
            if isItDay == true {
                return "cloudday"
            } else {
                return "cloudnight"
            }
            
        case 803...804 :
            return "cloudnight"
         
        default :
            if isItDay == true {
                return "sunny"
            } else {
                return "moon"
            }
        }
        
    }
    
}
