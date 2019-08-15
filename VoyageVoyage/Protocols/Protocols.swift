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
}

// Error

public protocol ShowErrorMessage {
    func showAlertNoConnectionError(with title: String, and message: String)
    
}

// Segue

public protocol GetMoneyChoosen {
    func updateMoneyInChoosen(data: String)
    func updateMoneyOutChoosen(data: String)
}

public protocol GetLangChoosen {
    func updateLangInChoosen(data: String, image: String)
    func updateLangOutChoosen(data: String, image: String)
}
