//
//  Protocols.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation

public protocol LocationDidUpdate {
    func updateWeatherData()
}

public protocol WeatherDidUpdate {
    func updateWeatherDataForcast()
}

public protocol WeatherForcastDidUpdate {
    func updateWeatherDataOnScreen()
}

public protocol ShowErrorMessage {
    func showAlertNoConnectionError(with title: String, and message: String)
    
}

public protocol ExchangeRateDidUptade {
    func updateExchangeRateValue()
}
