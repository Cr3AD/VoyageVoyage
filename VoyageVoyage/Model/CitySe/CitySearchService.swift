//
//  File.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class CitySearchService {
    
    static let shared = CitySearchService()
    private init() {}
    
    private static let googleAutocompletionURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    private static let googlePlaceURL = "https://maps.googleapis.com/maps/api/place/details/json?"
    private static let googleAPI = valueForAPIKey(named:"googleAPI")
    
    var errorMessageDelegate: ShowErrorMessage?
    var arrayOfAutoCompletionCities: [(city: String, id: String)] = []
    
    enum Error: Swift.Error {
        case errorNotNill
        case noData
        case wrongJSONReceived
        case notOK200
    }
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    func addCitiesSuggestions(city: String, id: String) {
        arrayOfAutoCompletionCities.append((city, id))
    }
    
    func getAutoCompletion(text: String, completionHandler: @escaping (AutoCompletionDataJSON?, Swift.Error?) ->()) {
        print("getAutoCompletion started")
        let url = "\(CitySearchService.googleAutocompletionURL)input=\(text)&key=\(CitySearchService.googleAPI)"
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
                    return completionHandler(nil, Error.errorNotNill)
                }
                do {
                    let autoCompletion = try JSONDecoder().decode(AutoCompletionDataJSON.self, from: data)
                        completionHandler(autoCompletion, nil)
                } catch {
                    self.showError(errorType: .wrongJSONReceived)
                    completionHandler(nil, Error.wrongJSONReceived)
                }
            }
        } .resume()
    }
    
    func getPlaceDetail(text: String, completionHandler: @escaping (PlaceDetailDataJSON?, Swift.Error?) ->()) {
        print("getPlaceDetail started")
        let url = "\(CitySearchService.googlePlaceURL)placeid=\(text)&key=(\(CitySearchService.googleAPI)"
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
                    return completionHandler(nil, Error.errorNotNill)
                }
                do {
                    let placeDetail = try JSONDecoder().decode(PlaceDetailDataJSON.self, from: data)
                    completionHandler(placeDetail, nil)
                } catch {
                    self.showError(errorType: .wrongJSONReceived)
                    completionHandler(nil, Error.wrongJSONReceived)
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
        case .wrongJSONReceived:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "The data received are corrupted")
        case .notOK200:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "Communication issue with the server, please check you internet connection")
        }
    }
}
