//
//  ExcangeRate.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 19/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import SwiftyJSON



struct ExchangeData {
    var data = [String: Double]()
}

class ExchangeRateManager {
    
    var exchangeValueDictionnary = ExchangeData()
    var exchangeRateDidUpdateDelegate: ExchangeRateDidUptade?

    // MARK : - JSON decode
    
    func updateCurrencyDictionnary(json: JSON) {
        
        exchangeValueDictionnary.data[json["base"].stringValue] = 1.0
        for (money, value) in json["rates"].dictionary! {
            exchangeValueDictionnary.data[money] = value.doubleValue
            print(value.doubleValue)
        }
        print("the exchange data is \(exchangeValueDictionnary)")
        NotificationCenter.default.post(Notification(name: Notification.Name("CurrencyRateDidUpdate")))
    }
    
    // MARK : - Money converter
    
    func currencyRequestConverter(valueIn: Double, currencyIn: String, currencyOut: String) throws -> String {

//        let valueOut = valueIn / exchangeValueDictionnary.data[currencyIn]! * exchangeValueDictionnary.data[currencyOut]!) {
        
            return String("value")
//        }
    }
}
