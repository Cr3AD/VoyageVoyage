//
//  MoneyManagerTests.swift
//  VoyageVoyageTests
//
//  Created by Cr3AD on 17/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import XCTest
@testable import VoyageVoyage

class MoneyManagerTests: XCTestCase {
    
    let moneyManager = MoneyManager()
    
    
    func testGivenMoneyInIs2EuroAndCurrencyOutIsInDollardsCurrencyConverterShouldReturnADouble() {
        
        // 1 € = 1,11$
        
        let valueOut = moneyManager.currencyRequestConverter(valueIn: 2, currencyIn: 1, currencyOut: 1.11)
        XCTAssert(valueOut == 2.22)
    }
}
