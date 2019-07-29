//
//  ExchangeViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 08/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit


class MoneyViewController: UIViewController, GetMoneyInChoosen, GetMoneyOutChoosen, ShowErrorMessage, MoneyData {
    
    @IBOutlet weak var textmoneyIn: UITextField!
    @IBOutlet weak var textmoneyOut: UITextField!
    @IBOutlet weak var textDataUpdatedTime: UILabel!
    @IBOutlet weak var buttonMoneyIn: UIButton!
    @IBOutlet weak var buttonMoneyOut: UIButton!
    @IBOutlet weak var conversionButton: UIButton!
    
    @IBAction func didTapProceedExchange(_ sender: Any) {
        convertMoney()
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
    
    func updateMoneyData() {
        let MONEY_URL = "http://api.exchangeratesapi.io/latest?base="
        networkService.networking(url: "\(MONEY_URL)\("EUR")", requestType: "moneyRate")
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
        conversionButton.isEnabled = true
    }

    func updateTimeDisplay() {
        textDataUpdatedTime.text = self.dataMoney?.date
    }
 
    func updateMoneyInChoosen(data: String) {
        buttonMoneyIn.setTitle(data, for: .normal)
    }
    
    func updateMoneyOutChoosen(data: String) {
        buttonMoneyOut.setTitle(data, for: .normal)
    }
    
    func convertMoney() {
        guard let valueIn = Double(textmoneyIn.text!) else {
            return
        }
        var rateIn:Double {
            if buttonMoneyIn.titleLabel!.text == dataMoney?.base {
                return 1.0
            } else {
                return Double((dataMoney?.rates[buttonMoneyIn.titleLabel!.text!])!)
            }
        }
        var rateOut:Double {
            if buttonMoneyOut.titleLabel!.text == dataMoney?.base {
                return 1.0
            } else {
                return Double((dataMoney?.rates[buttonMoneyOut.titleLabel!.text!])!)
            }
        }
        let result = moneyManager.currencyRequestConverter(valueIn: valueIn,
                                              currencyIn: rateIn,
                                              currencyOut: rateOut)
        textmoneyOut.text = String(format: "%.4f", result)
    }
    

    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                
            })
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
                
            })
            
            alert.addAction(reload)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
    
    
    

}


