//
//  makeATradViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 29/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class MakeATradViewController: UIViewController, ShowErrorMessage, GetLangChoosen, TranslationData  {

    
    @IBOutlet weak var mainView: UIView?
    @IBOutlet weak var languageInButton: UIButton?
    @IBOutlet weak var languageOutButton: UIButton?
    @IBOutlet weak var inversionButton: UIButton?
    @IBOutlet weak var translateButton: UIButton?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var traductionScrollView: UIScrollView?
    @IBAction func didTapTranslateButton(_ sender: Any) {
        updateTranslationData()
        
    }
    
    @IBAction func didTapReverseBUtton(_ sender: Any) {
        reverseTraductionButtons()
        
    }

    @IBAction func didTapTextField(_ sender: Any) {
        animateView(way: "up")
    }
    @IBAction func didUnTapTextField(_ sender: Any) {
        animateView(way: "down")
    }

    func animateView(way: String) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            let screenHeight = UIScreen.main.bounds.height
            if way == "up" {
                self.mainView?.center.y -= screenHeight / 3
            } else {
                self.mainView?.center.y += screenHeight / 3
            }
        })
    }

    let networkService = NetworkService()
    var dataTranslation: TranslationJSON?
    
    var langIn: String {
        return languageInButton?.titleLabel?.text ?? ""
    }

    var langOut: String {
        return languageOutButton?.titleLabel?.text ?? ""
    }

    var textIn: String {
        return textField?.text ?? ""
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
        viewSetup()
    }
    

    func delegatesSetUp() {
        networkService.translationDataDelegate = self
    }
    
    func viewSetup() {
        translateButton?.layer.cornerRadius = 5
    }

    func updateTranslationData() {
        if textField?.text != "" {
            
            let GOOGLE_URL = "https://translation.googleapis.com/language/translate/v2?"
            let googleAPI = valueForAPIKey(named:"googleAPI")
            do {
                try networkService.networking(url: "\(GOOGLE_URL)key=\(googleAPI)&q=\(textIn.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&source=\(langIn)&target=\(langOut)", requestType: "traduction")
            } catch let error {
                print(error)
            }
        }
    }
    
    func receiveTranslationData(_ data: TranslationJSON) {
        self.dataTranslation = data
        print("Data translation received")
        print(self.dataTranslation as Any)
        
        DispatchQueue.main.async {
            do {
                try self.updateTranslationDataOnScreen()
            } catch let error {
                print(error)
            }
        }
    }
    
    func updateLangInChoosen(data: String, image: String) {
        let image = UIImage(named: image)
        languageInButton?.setImage(image, for: .normal)
        languageInButton?.setTitle(data, for: .normal)
    }
    
    func updateLangOutChoosen(data: String, image: String) {
        let image = UIImage(named: image)
        languageOutButton?.setImage(image, for: .normal)
        languageOutButton?.setTitle(data, for: .normal)
    }
    
    func updateTranslationDataOnScreen() throws {
        
        guard let translatedText = dataTranslation?.data?.translations?[0].translatedText else {
            throw updateTranslationDataOnScreenError.cantReadDataInJSON
        }
        
        let textOut: String = translatedText
        makeTraductionView(langIn: langIn, langOut: langOut, textInput: textIn, textOutput: textOut)
        textField?.text?.removeAll()
    }
    
    enum updateTranslationDataOnScreenError: Error {
        case cantReadDataInJSON
    }
    
    func reverseTraductionButtons() {
        let temp1 = languageInButton?.titleLabel?.text
        let temp1image = languageInButton?.image(for: .normal)
        let temp2 = languageOutButton?.titleLabel?.text
        let temp2image = languageOutButton?.image(for: .normal)
        
        languageInButton?.setTitle(temp2, for: .normal)
        languageInButton?.setImage(temp2image, for: .normal)
        languageOutButton?.setTitle(temp1, for: .normal)
        languageOutButton?.setImage(temp1image, for: .normal)
    }

    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                self.updateTranslationData()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
            })
            alert.addAction(reload)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
}
