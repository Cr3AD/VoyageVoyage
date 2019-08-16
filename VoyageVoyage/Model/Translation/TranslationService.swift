//
//  TraductionService.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 13/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class TranslationService {
    static var shared = TranslationService()
    private init() {}
    
    private static let googleURL = "https://translation.googleapis.com/language/translate/v2?"
    private static let googleAPI = valueForAPIKey(named:"googleAPI")
    
    enum Error: Swift.Error {
        case noData
        case wrongJSONTranslationFormat
        case notOK200
    }
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    func getTraduction(textToTranslate: String, langIn: String, langOut: String, completionHandler: @escaping (TranslationDataJSON?, Swift.Error?) ->()) {
        print("getTraduction started")
        let url = "\(TranslationService.googleURL)key=\(TranslationService.googleAPI)&q=\(textToTranslate)&source=\(langIn)&target=\(langOut)"
        print(url)
        var request = URLRequest(url: URL(string: url)!)
        task?.cancel()
        request.httpMethod = "POST"
        session.dataTask(with: request) { (data, responce, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    return completionHandler(nil, error)
                }
                guard (responce as? HTTPURLResponse)?.statusCode == 200 else {
                    return completionHandler(nil, Error.notOK200)
                }
                guard let data = data else {
                    return completionHandler(nil, Error.noData)
                }
                do {
                    print("data received \(data)")
                    let translation = try JSONDecoder().decode(TranslationDataJSON.self, from: data)
                    completionHandler(translation, nil)
                } catch {
                    completionHandler(nil, Error.wrongJSONTranslationFormat)
                }
            }
        } .resume()
    }
    
    private(set) var traductions: [Traduction] = []
    
    func add(traduction: Traduction) {
        traductions.append(traduction)
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
