//
//  ExtentionTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 17/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage

class ExtentionTest: XCTestCase {
    
    func testGivenDoubleReturnInt() {
        let doubleNumber: Double = 1.1
        XCTAssert(doubleNumber.intValue == 1)
    }
    
    func testGivenDoubleReturnString() {
        let doubleNumber: Double = 1.1
        XCTAssert(doubleNumber.string == "1.1")
    }
    
    func testGivenIntReturnDoubleValue() {
        let intNumber: Int = 1
        XCTAssert(intNumber.doubleValue == 1.0)
    }
    
    func testGivenIntReturnStringValue() {
        let intNumber: Int = 1
        XCTAssert(intNumber.string == "1")
    }
    
    func testCGFloatRetunIntValue() {
        let cgFloatNumber: CGFloat = 1.1
        XCTAssert(cgFloatNumber.intValue == 1)
    }
    
    
}
