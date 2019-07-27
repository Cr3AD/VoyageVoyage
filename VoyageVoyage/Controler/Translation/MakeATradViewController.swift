//
//  makeATradViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 29/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class MakeATradViewController: UIViewController, ShowErrorMessage, GetLangInChoosen, GetLangOutChoosen, TranslationData  {
    
    @IBOutlet weak var languageInButton: UIButton!
    @IBOutlet weak var languageOutButton: UIButton!
    @IBOutlet weak var inversionButton: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var traductionScrollView: UIScrollView!
    @IBAction func didTapTranslateButton(_ sender: Any) {
        updateTranslationData()
    }

    
    let networkService = NetworkService()
    var dataTranslation: TranslationJSON?
    
    var langIn: String {
        return (languageInButton.titleLabel?.text)!
    }
    var langOut: String {
        return (languageOutButton.titleLabel?.text)!
    }
    
    var textIn: String {
        return textField.text!
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "langueInSegue" {
            let langTableView = segue.destination as! LanguageUITableViewController
            langTableView.delegateLangIn = self
        }
        if segue.identifier == "langueOutSegue" {
            let langTableView = segue.destination as! LanguageUITableViewController
            langTableView.delegateLangOut = self
        }
    }

    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        delegatesSetUp()
    }
    

    func delegatesSetUp() {
        networkService.translationDataDelegate = self
    }
    
    func updateTranslationData() {
        let GOOGLE_URL = "https://translation.googleapis.com/language/translate/v2?"
        let googleAPI = valueForAPIKey(named:"googleAPI")
        networkService.networking(url: "\(GOOGLE_URL)key=\(googleAPI)&q=\(textIn)&source=\(langIn)&target=\(langOut)", requestType: "traduction")
    }
    
    func receiveTranslationData(_ data: TranslationJSON) {
        self.dataTranslation = data
        print("Data translation received")
        print(self.dataTranslation as Any)
        
        DispatchQueue.main.async {
            self.updateTranslationDataOnScreen()
        }
    }
    

    func updateLangInChoosen(data: String) {
        languageInButton.setTitle(data, for: .normal)
    }
    
    func updateLangOutChoosen(data: String) {
        languageOutButton.setTitle(data, for: .normal)
    }
    
    func updateTranslationDataOnScreen() {
        let textOut: String = (dataTranslation?.data?.translations![0].translatedText)!
        addTraductionView(langIn: langIn, langOut: langOut, textInput: textIn, textOutput: textOut)
        textField.text?.removeAll()
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
