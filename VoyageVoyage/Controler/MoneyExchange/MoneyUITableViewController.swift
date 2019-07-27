//
//  MoneyUITableViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 19/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit



class MoneyAvailablel {
    let money: String
    
    init(for money: String) {
        self.money = money
    }
}

class MoneyUITableViewController: UITableViewController {
    
    let poolOfCurrency = ["EUR","GBP","CHF","AUD","USD","JPY","CAD"]
    let fullPoolOfCurrency = ["EUR","GBP","NOK","THB","CHF","INR","AUD","DKK","MYR","CZK","PHP","PLN","HRK","RUB","BRL","ISK","TRY","BGN","CNY","HKD","USD","MXN","KRW","SEK","NZD","HUF","ILS","RON","JPY","SGD","ZAR","IDR","CAD"]
    
    var delegateMoneyIn: GetMoneyInChoosen?
    var delegateMoneyOut: GetMoneyOutChoosen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolOfCurrency.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moneyCell") as! MoneyTableViewCell
        cell.moneyLabel.text = poolOfCurrency[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateMoneyIn?.updateMoneyInChoosen(data: poolOfCurrency[indexPath.row])
        delegateMoneyOut?.updateMoneyOutChoosen(data: poolOfCurrency[indexPath.row])
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
