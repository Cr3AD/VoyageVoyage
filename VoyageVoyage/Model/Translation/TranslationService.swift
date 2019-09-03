//
//  TraductionService.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 13/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class TranslationService {
    
    // MARK: - singleton patern
    
    static var shared = TranslationService()
    private init() {}
    
    // MARK: - proprieties
    
    private static let googleURL = "https://translation.googleapis.com/language/translate/v2?"
    private static let googleAPI = valueForAPIKey(named:"googleAPI")
    
    private(set) var translations: [Traduction] = []
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - delegate
    
    var errorMessageDelegate: ShowErrorMessage?
    
    // MARK: - Errors
    
    enum Error: Swift.Error {
        case errorNotNill
        case noData
        case wrongJSONTranslationFormat
        case notOK200
    }
    
    // MARK: - Methodes
    
    // add the translations to the translation array
    
    func add(translation: Traduction) {
        translations.append(translation)
    }
    
    func getTraduction(textToTranslate: String, langIn: String, langOut: String, completionHandler: @escaping (TranslationDataJSON?, Swift.Error?) ->()) {
        print("getTraduction started")
        let url = "\(TranslationService.googleURL)key=\(TranslationService.googleAPI)&q=\(textToTranslate)&source=\(langIn)&target=\(langOut)"
        var request = URLRequest(url: URL(string: url)!)
        task?.cancel()
        request.httpMethod = "POST"
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
                    let translation = try JSONDecoder().decode(TranslationDataJSON.self, from: data)
                    completionHandler(translation, nil)
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

struct Traduction: TraductionData {
    var langIn = ""
    var langOut = ""
    var textIn = ""
    var textOut = ""
}

protocol TraductionData {
    var langIn: String {get}
    var langOut: String {get}
    var textIn: String {get}
    var textOut: String {get}
}
