//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class MoneyTests: XCTestCase {
    
    var data: MoneyDataJSON?
    
    // MARK: - Weather tests
    func testGetMoneyShouldFailIfError() {
        // Given
        let moneyService = MoneyService(session: URLSessionFake(data: nil, response: nil, error: FakeResponceData.error))
        // When
        let expectation = XCTestExpectation(description: "wait queue to change")
        moneyService.getMoney { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMoneyShouldFailIfNoData() {
        let moneyService = MoneyService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        moneyService.getMoney { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMoneyShoudFailIfWrongData() {
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponceData.moneyIncorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        moneyService.getMoney { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMoneyShoudFailIfIncorrectResponse() {
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponceData.moneyCorrectData, response: FakeResponceData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        moneyService.getMoney { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetMoneyShoudSucceedIfNoErrorAndCorrectData() {
        let moneyService = MoneyService(session: URLSessionFake(data: FakeResponceData.moneyCorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        moneyService.getMoney { (data, error) in
            // Then
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}







