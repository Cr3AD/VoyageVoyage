//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class WeatherTests: XCTestCase, WeatherData {
    
    var expectation : XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    // MARK: - Weather tests
    func testGetWeatherShouldPostFaileIfError() {
        
        // Given
        
        let networkService = NetworkService(session: URLSessionFake(data: nil, response: nil, error: FakeResponceData.error))
        networkService.weatherDataDelegate = self
        
       
        expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        
        try! networkService.networking(url: "wwww.test.com", requestType: "weather")
        
        wait(for: [expectation], timeout: 0.01)
        
        // Then

    }
    func receiveWeatherData(_ data: WeatherJSON) {
        
        expectation.fulfill()
    }
    

}


//class totoTest {
//    /// var toto: Expextion
//    func testBadResponse() {
//        let networkService = NetworkService(session: URLSessioFake(/* */))
//        networkService.translationDataDleegate = self
//
//        // Create expectation and save on object toto
//
//
//        networkService.networkgin( /// )
//
//        // wait for expection
//
//
//    }
//
//    func masupperfonctionDuDelegate() {
//        //toto.fulfille()
//    }
//}
