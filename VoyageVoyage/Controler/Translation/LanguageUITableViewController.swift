//
//  MoneyUITableViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 19/07/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit



class LanguageAvailable {
    let language: String
    
    init(for language: String) {
        self.language = language
    }
}

class LanguageUITableViewController: UITableViewController {
    
    let poolOfLanguage = [("EN", "English"),
                          ("FR", "Français"),
                          ("ES", "Español"),
                          ("DE", "Deutsch"),
                          ("IT", "Italiano")]
    
    var delegateLangIn: GetLangInChoosen?
    var delegateLangOut: GetLangOutChoosen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolOfLanguage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "langCell") as! LanguageTableViewCell
        cell.languageLabel.text = poolOfLanguage[indexPath.row].1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateLangIn?.updateLangInChoosen(data: poolOfLanguage[indexPath.row].0)
        delegateLangOut?.updateLangOutChoosen(data: poolOfLanguage[indexPath.row].0)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}
