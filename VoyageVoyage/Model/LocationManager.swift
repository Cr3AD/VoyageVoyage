//
//  Location.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 27/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation


class LocationManager : NSObject, CLLocationManagerDelegate {
    
    // Instances
    
    let locationManager = CLLocationManager()
    
    // Delegate
    
    var locationDidUpdateDelegate: LocationDidUpdate?
    
    // Proprieties
    
    var latitude = 0.0
    var longitude = 0.0
    
    
    // MARK : - Location authorisation
    
    func enableBasicLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            print("Location service declined")
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            startLocationService()
            break
        @unknown default:
            print("error in location authorisation")
        }
    }

    // MARK : - start Location services
    
    func startLocationService() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            
            print("latitude \(String(location.coordinate.latitude)) longitude \(String(location.coordinate.longitude))")
            print("LocationDidUpdate")
//            NotificationCenter.default.post(Notification(name: Notification.Name("LocationDidUpdate")))
            locationDidUpdateDelegate?.updateWeatherData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
