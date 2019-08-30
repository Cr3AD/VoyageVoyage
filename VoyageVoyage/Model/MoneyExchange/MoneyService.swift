//
//  TraductionService.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 13/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class MoneyService {
    static var shared = MoneyService()
    private init() {}
    
    private let fixerURL = "http://data.fixer.io/api/latest?"
    private let fixerAPI = valueForAPIKey(named:"moneyAPI")
    
    var errorMessageDelegate: ShowErrorMessage?
    
    enum Error: Swift.Error {
        case errorNotNill
        case noData
        case wrongJSONMoneyFormat
        case notOK200
    }
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    func getMoney(completionHandler: @escaping (MoneyDataJSON?, Swift.Error?) ->()) {
        print("getMoney started")
        let url = "\(fixerURL)access_key=\(fixerAPI)&format=1"
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
                    print("data received \(data)")
                    let money = try JSONDecoder().decode(MoneyDataJSON.self, from: data)
                    completionHandler(money, nil)
                } catch {
                    self.showError(errorType: .wrongJSONMoneyFormat)
                    completionHandler(nil, Error.wrongJSONMoneyFormat)
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
        case .wrongJSONMoneyFormat:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "The data received are corrupted")
        case .notOK200:
            self.errorMessageDelegate?.showAlertNoConnectionError(title: "Error", message: "Communication issue with the server, please check you internet connection")
        }
    }
}


