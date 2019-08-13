//
//  FakeResponceData.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

class FakeResponceData {
    
    // MARK: - Data
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://www.openclassroom.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://www.openclassroom.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var forcastCorrectData: Data? {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Forcast", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var moneyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Money", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    static var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeResponceData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    // MARK: - Responce
    
    static let weatherIncorrectData = "error".data(using: .utf8)!
    static let forcastIncorrectData = "error".data(using: .utf8)!
    static let moneyIncorrectData = "error".data(using: .utf8)!
    static let translationIncorrectData = "error".data(using: .utf8)!
    
    // MARK: - Error
    
    
    class ClassError: Error {}
    static let error = ClassError()
}
