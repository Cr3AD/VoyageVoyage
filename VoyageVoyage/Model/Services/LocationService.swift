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

    static let shared = LocationService()
    
    // Instances
    
    let locationService = CLLocationManager()
    
    // Delegate
    
    var locationDidUpdateDelegate: DidUpdateLocation?
    
    // Proprieties
    
    private(set) var latitude = 0.0
    private(set) var longitude = 0.0
    
    func changeLocation(lat: Double, lon: Double) {
        latitude = lat
        longitude = lon
    }
    
    // MARK : - Location authorisation
    
    // check the location service authorisation
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
    
    // start the location service
    func startLocationService() {
        locationService.startUpdatingLocation()
    }
    
    // location service impossible
    func locationServiceImpossible() {
        locationService.stopUpdatingLocation()
        locationDidUpdateDelegate?.showUserNoLocationAvailable()
    }
    
    // location service did update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationService.stopUpdatingLocation()
            setLocation(at: location)
            sendData()
        }
    }
    
    // set the private set variables used for longitude and latitude
    func setLocation(at location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
    
    // start to get the weather data at the location
    func sendData() {
        print("send data")
        print(longitude)
        print(latitude)
        locationDidUpdateDelegate?.updateWeatherAndForcastDataAtLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    // start the methode enableBasicLocationService to check the location service authorisation
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        enableBasicLocationServices()
    }
}
