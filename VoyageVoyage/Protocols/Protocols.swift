//
//  Protocols.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

// Location

public protocol DidUpdateLocation {
    func updateWeatherAndForcastDataAtLocation()
    func showUserNoLocationAvailable()
}

// Error

public protocol ShowErrorMessage {
    func showAlertNoConnectionError(title: String, message: String)
}

// Segue

public protocol GetMoneyChoosen {
    func updateMoneyInChoosen(data: String)
    func updateMoneyOutChoosen(data: String)
}

public protocol GetLangChoosen {
    func updateLangInChoosen(imageName: String)
    func updateLangOutChoosen(imageName: String)
}
