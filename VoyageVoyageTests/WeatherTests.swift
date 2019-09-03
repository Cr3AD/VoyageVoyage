//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class WeatherTests: XCTestCase {
    
    var data: WeatherDataJson?
    
    // MARK: - Weather tests
    func testGetWeatherShouldFailIfError() {
        // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponceData.weatherCorrectData, response: FakeResponceData.responseOK, error: FakeResponceData.error))
        // When
        let expectation = XCTestExpectation(description: "wait queue to change")
        weatherService.getWeather(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    
    func testGetWeatherShouldFailIfNoData() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        weatherService.getWeather(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldFailIfWrongDataResponceOK() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponceData.weatherIncorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        weatherService.getWeather(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetWeatherShouldFailIfIncorrectResponse() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponceData.weatherCorrectData, response: FakeResponceData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        weatherService.getWeather(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldSucceedIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponceData.weatherCorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        weatherService.getWeather(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
