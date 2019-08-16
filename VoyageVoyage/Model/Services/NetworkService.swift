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

    static var shared = NetworkService()


    
    var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func networking(url: String, requestType: String) throws {
//
//        print("network service started for \(requestType)")
//
//        guard let requestUrl = URL(string: url) else {
//            throw networkRequestError.urlIssue
//        }
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "GET"
//
//        var task: URLSessionDataTask
//        task = session.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                self.showErrorMessageDelegate?.showAlertNoConnectionError(with: "Error", and: "Check your internet connection or retry later")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                self.showErrorMessageDelegate?.showAlertNoConnectionError(with: "Error", and: "Something goes wrong with the data received")
//                return
//            }
//
//            switch requestType {
//            case "weather":
//                do {
//                    let weatherJSON = try JSONDecoder().decode(WeatherJSON.self, from: data)
//                    print("weatherJSON received \(data)")
//                    self.weatherDataDelegate?.receiveWeatherData(weatherJSON)
//                } catch let jsonErr {
//                    print(jsonErr)
//                }
//            case "forcast":
//                do {
//                    let forcastJSON = try JSONDecoder().decode(ForcastJSON.self, from: data)
//                    print("forcastJSON received \(data)")
//                    self.forcastDataDelegate?.receiveForcastData(forcastJSON)
//                } catch let jsonErr {
//                    print(jsonErr)
//                }
//
//            case "traduction":
//                do {
//                    let translationJSON = try JSONDecoder().decode(TranslationJSON.self, from: data)
//                    print("translationJSON received \(data)")
//                    self.translationDataDelegate?.receiveTranslationData(translationJSON)
//                } catch let jsonErr {
//                    print(jsonErr)
//                }
//
//            case "moneyRate":
//                do {
//                    var moneyJSON = try JSONDecoder().decode(MoneyJSON.self, from: data)
//                    moneyJSON.rates["EUR"] = 1.0
//                    print("moneyRateJSON received \(data)")
//                    self.moneyDataDelegate?.receiveMoneyData(moneyJSON)
//                } catch let jsonErr {
//                    print(jsonErr)
//                }
//            default:
//                print("error")
//            }
//        }
//        task.resume()
    }
}


