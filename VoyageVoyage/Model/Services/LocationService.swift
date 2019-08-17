//
//  Location.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import CoreLocation


class LocationService : NSObject, CLLocationManagerDelegate {

    // Instances
    
    let locationService = CLLocationManager()
    
    // Delegate
    
    var locationDidUpdateDelegate: DidUpdateLocation?
    
    // Proprieties
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    // MARK : - Location authorisation
    
    func enableBasicLocationServices() {
        locationService.delegate = self
        locationService.desiredAccuracy = kCLLocationAccuracyHundredMeters
        let authorisation = CLLocationManager.authorizationStatus()
        switch authorisation {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationService.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            // Disable location features
            locationServiceImpossible()
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            startLocationService()
            
        @unknown default:
            print("error in location authorisation")
            locationServiceImpossible()
        }
    }

    // MARK : - start Location services
    
    func startLocationService() {
        locationService.startUpdatingLocation()
    }
    
    func locationServiceImpossible() {
        locationService.stopUpdatingLocation()
        locationDidUpdateDelegate?.showUserNoLocationAvailable()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationService.stopUpdatingLocation()
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            
            print("latitude \(String(location.coordinate.latitude)) longitude \(String(location.coordinate.longitude))")
            print("LocationDidUpdate")
            locationDidUpdateDelegate?.updateWeatherAndForcastDataAtLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableBasicLocationServices()
    }
}
