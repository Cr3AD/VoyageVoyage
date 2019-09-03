//
//  ExcangeRate.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 19/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation


class MoneyManager {
    
    // calculate the output
    
    func currencyRequestConverter(valueIn: Double, currencyIn: Double, currencyOut: Double) -> Double {
        let result = valueIn / currencyIn * currencyOut
        return result
    }
}

