//
//  ExchangeViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 08/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit


class MoneyViewController: UIViewController {
    
    // Mark: - IBOutlets
    
    @IBOutlet weak var textmoneyIn: UITextField?
    @IBOutlet weak var textmoneyOut: UITextField?
    @IBOutlet weak var textDataUpdatedTime: UILabel?
    @IBOutlet weak var buttonMoneyIn: UIButton?
    @IBOutlet weak var buttonMoneyOut: UIButton?
    @IBOutlet weak var conversionButton: UIButton?
    
    // Mark : - IBAction
    
    @IBAction func didTapProceedExchange(_ sender: Any) {
        do {
        try updateConversionOnScreen()
        } catch let error {
            print(error)
        }
    }
    
    // MARK: - Proprieties
    
    private let moneyService = MoneyService.shared
    private let moneyManager = MoneyManager()
    private var dataMoney: MoneyDataJSON?
    
    // MARK: - Segues
    
    enum segueType: String {
        case moneyInSegue = "moneyInSegue"
        case moneyOutSegue = "moneyOutSegue"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueType.moneyInSegue.rawValue {
            let moneyTableView = segue.destination as! MoneyUITableViewController
            moneyTableView.delegateMoneyIn = self
        }
        if segue.identifier == segueType.moneyOutSegue.rawValue {
            let moneyTableView = segue.destination as! MoneyUITableViewController
            moneyTableView.delegateMoneyOut = self
        }
    }
    
    // MARK - ViewDidLoad
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        delegateSetup()
        updateMoneyData()
    }
    
    private func delegateSetup() {
        moneyService.errorMessageDelegate = self
    }
    
    //MARK: - Download Data for Money exchange
    

    private func updateMoneyData() {
        MoneyService.shared.getMoney { (data, error) in
            guard error == nil else {
//                self.showError(error)
                print(error as Any)
                return
            }
            self.dataMoney = data
            self.updateMoneyInfoOnScreen()
        }
        
    }
    
    // MARK: - Update Data on the screen
    
    enum convertMoneyError: Error {
        case noTextButtonIn
        case noTextButtonOut
        case noTextIn
        case textInNotADouble
        case noRateIn
        case noRateOut
    }
    
    private func updateConversionOnScreen() throws {
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
    
    private func updateMoneyInfoOnScreen() {
        self.updateTimeDisplay()
        self.activateConversionButton()
    }
    
    private func activateConversionButton() {
        conversionButton?.isEnabled = true
    }
    
    private func updateTimeDisplay() {
        textDataUpdatedTime?.text = self.dataMoney?.date
    }  
}

extension MoneyViewController: GetMoneyChoosen {
    internal func updateMoneyInChoosen(data: String) {
        buttonMoneyIn?.setTitle(data, for: .normal)
    }
    internal func updateMoneyOutChoosen(data: String) {
        buttonMoneyOut?.setTitle(data, for: .normal)
    }
}

extension MoneyViewController: ShowErrorMessage {
    func showAlertNoConnectionError(title: String, message: String) {
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
