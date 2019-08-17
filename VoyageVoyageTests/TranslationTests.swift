//
//  VoyageVoyageTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 31/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage



class TranslationTests: XCTestCase {
    
    var data: TranslationDataJSON?
    
    // MARK: - Weather tests
    func testGetTranslationShouldFailIfError() {
        // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponceData.translationCorrectData, response: FakeResponceData.responseOK, error: FakeResponceData.error))
        // When
        let expectation = XCTestExpectation(description: "wait queue to change")
        translationService.getTraduction(textToTranslate: "Salut", langIn: "FR", langOut: "EN") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShouldFailIfNoData() {
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        translationService.getTraduction(textToTranslate: "Salut", langIn: "FR", langOut: "EN") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShoudFailIfWrongData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponceData.translationIncorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        translationService.getTraduction(textToTranslate: "Salut", langIn: "FR", langOut: "EN") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShoudFailIfIncorrectResponse() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponceData.translationCorrectData, response: FakeResponceData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        translationService.getTraduction(textToTranslate: "Salut", langIn: "FR", langOut: "EN") { (data, error) in
            // Then
            XCTAssert(error != nil)
            XCTAssert(data == nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetTranslationShoudSucceedIfNoErrorAndCorrectData() {
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponceData.translationCorrectData, response: FakeResponceData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "wait queue to change")
        translationService.getTraduction(textToTranslate: "Salut", langIn: "FR", langOut: "EN") { (data, error) in
            // Then
            XCTAssert(error == nil)
            XCTAssert(data != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}







