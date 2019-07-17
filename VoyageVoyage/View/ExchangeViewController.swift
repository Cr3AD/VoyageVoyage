//
//  ExchangeViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 08/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit


class ExchangeViewController: UIViewController, ExchangeRateDidUptade {
    
    
    
    // MARK: - Money PickerView
    
    // MARK: - Money Converter
    
    let poolOfCurrency = ["EUR","GBP","NOK","THB","CHF","INR","AUD","DKK","MYR","CZK","PHP","PLN","HRK","RUB","BRL","ISK","TRY","BGN","CNY","HKD","USD","MXN","KRW","SEK","NZD","HUF","ILS","RON","JPY","SGD","ZAR","IDR","CAD"]
    var moneyInChoosen = ""
    var moneyOutChoosen = ""
    
    
    
    func updateExchangeRateValue() {
        DispatchQueue.main.async {
            
        }
    }
}


