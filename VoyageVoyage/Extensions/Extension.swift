//
//  Extentions.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 09/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
