//
//  CitySearch.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 20/08/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class CitySearch: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var citySuggestionTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapSearchButton() {
        getAutoCompletionData(suggestion: citySearchTextField.text!) // .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    @IBAction func didTapLocationButton(_ sender: Any) {
        locationService.enableBasicLocationServices()
        self.dismiss(animated: true, completion: nil)
    }
    
    private let locationService = LocationService.shared
    private let citySearchService = CitySearchService.shared
    private var dataAutoCompletion: AutoCompletionDataJSON?
    private var dataPlaceDetail: PlaceDetailDataJSON?
    private var weatherDelegate: DidUpdateLocation?

    var delegateDidUpdateLocation: DidUpdateLocation?
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        delegateSetUp()
        citySearchTextField.becomeFirstResponder()
        searchButton.layer.cornerRadius = 5
    }
    
    func delegateSetUp() {
        
    }

    
    enum errors: Error {
        case noCitySuggested
        case noLatFoundInJSON
        case noLonFoundInJSON
    }
    
    // MARK: - Methodes
    
    // get auto completion suggestions from google API base on citySearchTextField.text
    private func getAutoCompletionData(suggestion: String) {
        let suggestion = suggestion
        citySearchService.getAutoCompletion(text: suggestion) { (data, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            self.dataAutoCompletion = data
            self.createArrayOfSuggestions()
            self.citySuggestionTableView.reloadData()
        }
    }
    
    
    // put the data received in an array to use it in the tableView
    private func createArrayOfSuggestions() {
        guard let prediction = dataAutoCompletion?.predictions else {
            return
        }
        citySearchService.arrayOfAutoCompletionCities.removeAll()
        for i in prediction {
            guard let city = i.predictionDescription else {
                return
            }
            guard let id = i.placeID else {
                return
            }
            citySearchService.createArrayOfSuggestions(city: city, id: id)
        }
    }
    
    private func getPlaceDetail(id: String) {
        print("getPlaceDetail for \(id)")
        citySearchService.getPlaceDetail(text: id) { (data, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            self.dataPlaceDetail = data
            do {
                try self.updateLocation()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func updateLocation() throws {
        print("update new Location")

        guard let lat = dataPlaceDetail?.result?.geometry?.location?.lat else {
            throw errors.noLatFoundInJSON
        }
        guard let lon = dataPlaceDetail?.result?.geometry?.location?.lng else {
            throw errors.noLonFoundInJSON
        }
        print(lat)
        print(lon)
        
        self.locationService.changeLocation(lat: lat, lon: lon)
        self.locationService.sendData()
    }
    
}

extension CitySearch: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citySearchService.arrayOfAutoCompletionCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citySuggestionCell", for: indexPath) as! CityTableViewCell
        let cityName = citySearchService.arrayOfAutoCompletionCities[indexPath.row].city
        cell.configure(cityName: cityName)
        return cell
    }
}

extension CitySearch: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cityRequestedID = citySearchService.arrayOfAutoCompletionCities[indexPath.row].id
        getPlaceDetail(id: cityRequestedID)
        
        self.dismiss(animated: true, completion: nil)
    }
}








