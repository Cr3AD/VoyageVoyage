//
//  DataAtLocation.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 04/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import SwiftyJSON



class Networking {
    let myAPI = MyAPI()
    
    let findLocation = LocationManager()
    let weatherData = WeatherManager()
    let exchangeRateManager = ExchangeRateManager()
    let translationManager = TranslationManager()
    
    var showErrorMessageDelegate : ShowErrorMessage?
    
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast"
    let MONEY_URL = "https://api.exchangeratesapi.io/latest?base="
    let GOOGLE_URL = "https://translation.googleapis.com/language/translate/v2?"
    
    enum networkRequestError {
        case noInternet
        case noAnswer
    }
    
    func startLocation() {
        findLocation.enableBasicLocationServices()
    }
    func updateWeatherData() {
        let lat = String(findLocation.latitude)
        let lon = String(findLocation.longitude)
        networking(url: "\(WEATHER_URL)?APPID=\(myAPI.weatherAPI)&lon=\(lon)&lat=\(lat)", requestType: "weather")
    }
    
    func updateWeatherForcast() {
        let lat = String(findLocation.latitude)
        let lon = String(findLocation.longitude)
        networking(url: "\(FORCAST_URL)?APPID=\(myAPI.weatherAPI)&lon=\(lon)&lat=\(lat)&cnt=5", requestType: "forcast")
    }
    
    func updateEchangeRateData() {
        networking(url: "\(MONEY_URL)\("EUR")", requestType: "moneyRate")
    }
    
    func makeATrad(textInput: String, langIn: String, langOut: String) {
        networking(url: "\(GOOGLE_URL)key=\(myAPI.googleAPI)&q=\(textInput)&source=\(langIn)&target=\(langOut)", requestType: "traduction")
        
    }

    
    func networking(url: String, requestType: String) {
  
        let session = URLSession(configuration: .default)
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let myJSON : JSON = JSON(data)
                    print("json \(requestType) \(myJSON)")
                    switch requestType {
                    case "weather":
                        self.weatherData.updateWeaterData(json: myJSON)
                    case "forcast":
                        self.weatherData.updateWeatherDataForcase(json: myJSON)
                    case "traduction":
                        self.translationManager.makeATranslation(json: myJSON)
                    case "moneyRate":
                        self.exchangeRateManager.updateCurrencyDictionnary(json: myJSON)
                    default:
                        print("error")
                    }
                }
            } else {
                self.showErrorMessageDelegate?.showAlertNoConnectionError(with: "Error", and: "Check your internet connection or retry later")
            }
        }
        task.resume()
    }
    
}
