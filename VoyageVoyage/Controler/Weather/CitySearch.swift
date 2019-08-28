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
    
    // MARK: - IBActions
    
    @IBAction func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchACity() {
        getAutoCompletionData(text: citySearchTextField.text!)
    }
    
    @IBAction func didTapLocationButton(_ sender: Any) {
        locationService.enableBasicLocationServices()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        delegateSetUp()
    }
    
    func delegateSetUp() {
        
    }
    
    // MARK: - Proprieties
    
    private let locationService = LocationService()
    private let citySearchService = CitySearchService.shared
    private var dataAutoCompletion: AutoCompletionDataJSON?
    private var dataPlaceDetail: PlaceDetailDataJSON?
    
    enum errors: Error {
        case noTextInCitySearchTextField
    }
    
    // MARK: - Methodes
    
    // get auto completion suggestions from google API base on citySearchTextField.text
    private func getAutoCompletionData(text: String) {
        let suggestion = citySearchTextField.text ?? ""
        if suggestion != "" {
            CitySearchService.shared.getAutoCompletion(text: suggestion) { (data, error) in
                guard error == nil else {
                    print(error as Any)
                    return
                }
                self.dataAutoCompletion = data
                self.createArrayOfSuggestions()
                self.citySuggestionTableView.reloadData()
            }
        }
        
    }
    
    // put the data received in an array to use it in the tableView
    private func createArrayOfSuggestions() {
        if let prediction = dataAutoCompletion?.predictions {
            citySearchService.arrayOfAutoCompletionCities.removeAll()
            for i in prediction {
                let city = i.predictionDescription!
                let id = i.placeID!
                citySearchService.addCitiesSuggestions(city: city, id: id)
            }
        }
    }
    
    

}

extension CitySearch: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CitySearchService.shared.arrayOfAutoCompletionCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citySuggestionCell", for: indexPath) as! CityTableViewCell
        let cityName = citySearchService.arrayOfAutoCompletionCities[indexPath.row].city
        cell.configure(cityName: cityName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.dismiss(animated: true, completion: nil)
        
        //        let cityID = citySearchService.arrayOfAutoCompletionCities[indexPath.row].id
        //        print(cityID)
        //        citySearchService.getPlaceDetail(text: cityID) { (data, error) in
        //            guard error == nil else {
        //                // self.showError(error)
        //                print(error as Any)
        //                return
        //            }
        //            self.dataPlaceDetail = data
        //            self.dismiss(animated: true, completion: nil)
        //        }
        //
        
    }
    
}



