//
//  DataAtLocation.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 04/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation



class NetworkService {

    var showErrorMessageDelegate : ShowErrorMessage?
    var weatherDataDelegate: WeatherData?
    var forcastDataDelegate: ForcastData?
    var moneyDataDelegate: MoneyData?
    var translationDataDelegate: TranslationData?
    

    enum networkRequestError {
        case noInternet
        case noAnswer
    }
    

    
    func networking(url: String, requestType: String) {
        
        print("network service started for \(requestType)")


        let session = URLSession(configuration: .default)
        let requestUrl = URL(string: url)
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    switch requestType {
                    case "weather":
                        do {
                            let weatherJSON = try JSONDecoder().decode(WeatherJSON.self, from: data)
                            print("weatherJSON received \(data)")
                            self.weatherDataDelegate?.receiveWeatherData(weatherJSON)
                        } catch let jsonErr {
                            print(jsonErr)
                        }
                    case "forcast":
                        do {
                            let forcastJSON = try JSONDecoder().decode(ForcastJSON.self, from: data)
                            print("forcastJSON received \(data)")
                            self.forcastDataDelegate?.receiveForcastData(forcastJSON)
                        } catch let jsonErr {
                            print(jsonErr)
                        }
                        
                    case "traduction":
                        do {
                            let translationJSON = try JSONDecoder().decode(TranslationJSON.self, from: data)
                            print("translationJSON received \(data)")
                            self.translationDataDelegate?.receiveTranslationData(translationJSON)
                        } catch let jsonErr {
                            print(jsonErr)
                        }
                        
                    case "moneyRate":
                        do {
                            let moneyJSON = try JSONDecoder().decode(MoneyJSON.self, from: data)
                            print("moneyRateJSON received \(data)")
                            self.moneyDataDelegate?.receiveMoneyData(moneyJSON)
                        } catch let jsonErr {
                            print(jsonErr)
                        }
                    default:
                        print("error")
                    }
                } else {
                    self.showErrorMessageDelegate?.showAlertNoConnectionError(with: "Error", and: "Data received corrupted")
                }
            } else {
                self.showErrorMessageDelegate?.showAlertNoConnectionError(with: "Error", and: "Check your internet connection or retry later")
            }
        }
        
        task.resume()
    }
    
}

