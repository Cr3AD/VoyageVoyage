//
//  FakeResponceData.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class FakeResponceData {
    let responceOK = HTTPURLResponse(url: URL(string: "https://www.test.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responceKO = HTTPURLResponse(url: URL(string: "https://www.test.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class WeatherError: Error {}
    let weaterError = WeatherError
    
    class ForcastError: Error {}
    let forcastError = ForcastError
    
    class MoneyError: Error {}
    let moneyError: Moneyerror
    
    class TranslationError: Error {}
    let translationError = TranslationError
    
    var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
        
    }
    var forcastCorrectData: Data {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Forcast", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
        
    }
    var moneyCorrectData: Data {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Money", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
        
    }
    var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
        
    }
    
    let weatherIncorrectData = "erreur".data(using: .utf8)!
    let forcastIncorrectData = "erreur".data(using: .utf8)!
    let moneyIncorrectData = "erreur".data(using: .utf8)!
    let tranlsationIncorrectData = "erreur".data(using: .utf8)!
    
    
}

