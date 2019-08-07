//
//  Extentions.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 09/06/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

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

extension Double {
    var intValue: Int {
        return Int(self)
    }
    
    var string: String {
        return "\(self)"
    }
}

extension Int {
    var doubleValue: Double {
        return Double(self)
    }
    
    var string: String {
        return "\(self)"
    }
}

extension CGFloat {
    var intValue: Int {
        return Int(self)
    }
}


