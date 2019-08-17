//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class ForcastTests: XCTestCase {
    
    var data: ForcastDataJSON?
    
    // MARK: - Weather tests
    func testGetForcastShouldFailIfError() {
        // Given
        let forcastService = ForcastService(session: URLSessionFake(data: FakeResponceData.forcastCorrectData, response: FakeResponceData.responseOK, error: FakeResponceData.error))
        // When
        let expectation = XCTestExpectation(description: "wait queue to change")
        forcastService.getForcast(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetForcastShouldFailIfNoData() {
        let forcastService = ForcastService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        forcastService.getForcast(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetForcastShoudFailIfWrongData() {
        let forcastService = ForcastService(session: URLSessionFake(data: FakeResponceData.forcastIncorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        forcastService.getForcast(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetForcastShoudFailIfIncorrectResponse() {
        let forcastService = ForcastService(session: URLSessionFake(data: FakeResponceData.forcastCorrectData, response: FakeResponceData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        forcastService.getForcast(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetForcastShoudSucceedIfNoErrorAndCorrectData() {
        let forcastService = ForcastService(session: URLSessionFake(data: FakeResponceData.forcastCorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        forcastService.getForcast(lat: "0", lon: "0") { (data, error) in
            // Then
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}







