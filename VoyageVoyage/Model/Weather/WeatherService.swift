//
//  TraductionService.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 13/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class WeatherService {
    
    static var shared = WeatherService()
    private init() {}
    
    private static let openweatherURL = "http://api.openweathermap.org/data/2.5/weather"
    private static let openweatherAPI = valueForAPIKey(named:"weatherAPI")
    
    var errorMessageDelegate: ShowErrorMessage?

    
    enum Error: Swift.Error {
        case errorNotNill
        case noData
        case wrongJSONTranslationFormat
        case notOK200
    }
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
  
    func getWeather(lat: String, lon: String, completionHandler: @escaping (WeatherDataJSON?, Swift.Error?) ->()) {
        print("getWeather started")
        
        let url = "\(WeatherService.openweatherURL)?APPID=\(WeatherService.openweatherAPI)&lon=\(lon)&lat=\(lat)"
        var request = URLRequest(url: URL(string: url)!)
        task?.cancel()
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, responce, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    self.showError(errorType: .noData)
                    return completionHandler(nil, Error.noData)
                }
                guard (responce as? HTTPURLResponse)?.statusCode == 200 else {
                    self.showError(errorType: .notOK200)
                    return completionHandler(nil, Error.notOK200)
                }
                guard error == nil else {
                    self.showError(errorType: .errorNotNill)
                    return completionHandler(nil, error)
                }
                do {
                    let weather = try JSONDecoder().decode(WeatherDataJSON.self, from: data)
                    completionHandler(weather, nil)
                } catch {
                    self.showError(errorType: .wrongJSONTranslationFormat)
                    completionHandler(nil, Error.wrongJSONTranslationFormat)
                }
            }
        } .resume()
    }
    
    func showError(errorType: Error) {
        switch errorType {
        case .errorNotNill:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "No data where received, please check you internet connection")
        case .noData:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "No data where received from the server")
        case .wrongJSONTranslationFormat:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "The data received are corrupted")
        case .notOK200:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "Communication issue with the server, please check you internet connection")
        }
    }
}