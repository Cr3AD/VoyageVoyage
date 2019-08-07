//
//  ExchangeViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 08/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit


class MoneyViewController: UIViewController, GetMoneyInChoosen, GetMoneyOutChoosen, ShowErrorMessage, MoneyData {
    
    @IBOutlet weak var textmoneyIn: UITextField?
    @IBOutlet weak var textmoneyOut: UITextField?
    @IBOutlet weak var textDataUpdatedTime: UILabel?
    @IBOutlet weak var buttonMoneyIn: UIButton?
    @IBOutlet weak var buttonMoneyOut: UIButton?
    @IBOutlet weak var conversionButton: UIButton?
    
    @IBAction func didTapProceedExchange(_ sender: Any) {
        do {
        try convertMoney()
        } catch let error {
            print(error)
        }
    }
    
    let networkService = NetworkService()
    let moneyManager = MoneyManager()
    var dataMoney: MoneyJSON?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moneyInSegue" {
            let moneyTableView = segue.destination as! MoneyUITableViewController
            moneyTableView.delegateMoneyIn = self
        }
        if segue.identifier == "moneyOutSegue" {
            let moneyTableView = segue.destination as! MoneyUITableViewController
            moneyTableView.delegateMoneyOut = self
        }
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        updateMoneyData()
        delegateSetup()
    }
    
    func delegateSetup() {
        networkService.moneyDataDelegate = self
    }
    
    // change for fixer http://data.fixer.io/api/latest?access_key=(API)&format=1
    func updateMoneyData() {
        let moneyAPI = valueForAPIKey(named:"moneyAPI")
        let MONEY_URL = "http://data.fixer.io/api/latest?access_key=\(moneyAPI)&format=1"
        
        do {
            try networkService.networking(url: MONEY_URL, requestType: "moneyRate")
        } catch let error {
            print(error)
        }
    }
    
    func receiveMoneyData(_ data: MoneyJSON) {
        self.dataMoney = data
        print("Data money received")
        print(self.dataMoney as Any)
        
        DispatchQueue.main.async {
            
            self.updateTimeDisplay()
            self.activateConversionButton()
        }
    }

    func activateConversionButton() {
        conversionButton?.isEnabled = true
    }

    func updateTimeDisplay() {
        textDataUpdatedTime?.text = self.dataMoney?.date
    }
 
    func updateMoneyInChoosen(data: String) {
        buttonMoneyIn?.setTitle(data, for: .normal)
    }
    
    func updateMoneyOutChoosen(data: String) {
        buttonMoneyOut?.setTitle(data, for: .normal)
    }
    
    func convertMoney() throws {
        guard let textButtonIn = buttonMoneyIn?.titleLabel?.text else {
            throw convertMoneyError.noTextButtonIn
        }
        guard let textButtonOut = buttonMoneyOut?.titleLabel?.text else {
            throw convertMoneyError.noTextButtonOut
        }
        guard let textIn = textmoneyIn?.text else {
            throw convertMoneyError.noTextIn
        }
        guard let valueIn: Double = Double(textIn) else {
            throw convertMoneyError.textInNotADouble
        }
        guard let rateIn: Double = dataMoney?.rates[textButtonIn] else {
            throw convertMoneyError.noRateIn
        }
        guard let rateOut: Double = dataMoney?.rates[textButtonOut] else {
            throw convertMoneyError.noRateOut
        }
        
        let result = moneyManager.currencyRequestConverter(valueIn: valueIn,
                                                           currencyIn: rateIn,
                                                           currencyOut: rateOut)
        textmoneyOut?.text = String(format: "%.4f", result)
    }
    
    enum convertMoneyError: Error {
        case noTextButtonIn
        case noTextButtonOut
        case noTextIn
        case textInNotADouble
        case noRateIn
        case noRateOut
    }

    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                self.updateMoneyData()
            })
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in  
            })
            
            alert.addAction(reload)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
}


