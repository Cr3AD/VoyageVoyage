//
//  MoneyUITableViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 19/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit



class MoneyUITableViewController: UITableViewController {
    
    let poolOfCurrency = [("EUR", "Euro", "euro"),
                          ("GBP", "Pounds", "unitedkingdom"),
                          ("USD", "US Dollard", "usa"),
                          ("AUD", "Australian Dollard", "australia"),
                          ("NOK", "Norwagian Krone", "norway"),
                          ("JPY", "Japanese Yen", "japan"),
                          ("CAD", "Canadian Dollard", "canada"),
                          ("CNY", "Yuan", "china")]
    
//    let fullPoolOfCurrency = ["EUR","GBP","NOK","THB","CHF","INR","AUD","DKK","MYR","CZK","PHP","PLN","HRK","RUB","BRL","ISK","TRY","BGN","CNY","HKD","USD","MXN","KRW","SEK","NZD","HUF","ILS","RON","JPY","SGD","ZAR","IDR","CAD"]
    
    var delegateMoneyIn: GetMoneyChoosen?
    var delegateMoneyOut: GetMoneyChoosen?
    
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
        cell.moneyLabel?.text = poolOfCurrency[indexPath.row].1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateMoneyIn?.updateMoneyInChoosen(data: poolOfCurrency[indexPath.row].0
        )
        delegateMoneyOut?.updateMoneyOutChoosen(data: poolOfCurrency[indexPath.row].0
        )
        self.dismiss(animated: true, completion: nil)
    }
}
