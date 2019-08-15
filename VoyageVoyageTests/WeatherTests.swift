//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class WeatherTests: XCTestCase, WeatherData, ShowErrorMessage {
    func showAlertNoConnectionError(with title: String, and message: String) {
        XCTFail("Error \(title)")
    }
    
    
    var expectation: XCTestExpectation?
    var data: WeatherJSON?
    
    
    
    // MARK: - Weather tests
    func testGetWeatherShouldPostFaileIfError() {
        
        // Given
        
        let networkService = NetworkService(session: URLSessionFake(data: nil, response: nil, error: FakeResponceData.error))
        networkService.weatherDataDelegate = self
        networkService.showErrorMessageDelegate = self
        
       
        expectation = XCTestExpectation(description: "Wait for queue change.")
        
        // When
        
        try! networkService.networking(url: "http://api.openweathermap.org/data/2.5/weather", requestType: "weather")
        
        wait(for: [expectation!], timeout: 5)
        
        // Then
        XCTAssertNil(data)

    }
    func receiveWeatherData(_ data: WeatherJSON) {
        self.data = data
        expectation?.fulfill()
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
