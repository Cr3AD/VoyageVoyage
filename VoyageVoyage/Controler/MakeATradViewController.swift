//
//  makeATradViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 29/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class MakeATradViewController: UIViewController {
    

    // Connections
    
    private let translate = TranslationManager()
    private let getData = Networking()
    
    // ViewDidLoad
    
    override func viewDidLoad() {
        // Delegate
        delegatesSetUp()
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTraductionOnScreen(_:)), name: Notification.Name("TraductionDataDidUpdate"), object: nil)
    }
    
    func delegatesSetUp() {
        getData.exchangeRateManager
    }

    // error enumeration
    
    enum getATraductionError: Error {
        case noTextInTextField
    }
    
    // IBAction
    
    @IBAction func dismisSwipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapTranslateButton(_ sender: Any) {
        buttonIsTapped()
    }
    
    // IBOutlets
    @IBOutlet weak var textFieldToTranslate: UITextField!
    
    
    // Notifications reception
    
    
    @objc func updateTraductionOnScreen(_ notification: Notification) {
        
        // update the traduction on screen
        
        print("traduction ok \(getData.translationManager.textOut)")
    }
    
    // Methodes
    
    private func buttonIsTapped() {
        
        do {
            try requestTraduction(with: textFieldToTranslate.text!)
        } catch let error {
            print("error: \(error)")
        }
        
    }
    
    private func requestTraduction(with text: String) throws {
        guard textFieldToTranslate.text != "" else {
            throw getATraductionError.noTextInTextField
        }

        getData.makeATrad(textInput: text, langIn: "FR", langOut: "EN")
        print("text to translate is : \(text)")
    }
    
}
