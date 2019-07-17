//
//  ViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 23/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, LocationDidUpdate, WeatherDidUpdate, WeatherForcastDidUpdate, ShowErrorMessage {


    // MARK: - Instances
    
    let getData = Networking()
    let money = ExchangeRateManager()
    
    
    
    // MARK: - Outlets
    
    // weather

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempDataLabel: UILabel!
    @IBOutlet weak var weatherDescriptionDataLabel: UILabel!
    
    @IBOutlet weak var maxTempDataLabel: UILabel!
    @IBOutlet weak var minTempDataLabel: UILabel!
    
    @IBOutlet weak var windDataLabel: UILabel!
    @IBOutlet weak var sunriseDataLabel: UILabel!
    @IBOutlet weak var sunsetDataLabel: UILabel!
    @IBOutlet weak var weatherHumidityDataLabel: UILabel!

    @IBOutlet weak var forcastScrollView: UIScrollView!
    @IBOutlet weak var secondForcastScrollView: UIScrollView!
    
    // MARK: - override func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // configure location
        getData.startLocation()
        
        // get exchange Rate
        getData.updateEchangeRateData()
        
        // Delegate
        delegatesSetUp() 
    }
    
    private func delegatesSetUp() {
        getData.findLocation.locationDidUpdateDelegate = self
        getData.weatherData.weatherDidUpdateDelegate = self
        getData.weatherData.WeatherForcastDidUpdateDelegate = self
        getData.showErrorMessageDelegate = self
    }
    
    
    // MARK: - Delegate functions
    
    func updateWeatherData() {
        getData.updateWeatherData()
    }
    
    func updateWeatherDataForcast() {
        getData.updateWeatherForcast()
    }
    
    func updateWeatherDataOnScreen() {
        
        DispatchQueue.main.async {
            self.cityLabel.text = self.getData.weatherData.city
            self.tempDataLabel.text = self.getData.weatherData.temperature
            self.minTempDataLabel.text = self.getData.weatherData.temperatureMin
            self.maxTempDataLabel.text = self.getData.weatherData.temperatureMax
            self.windDataLabel.text = self.getData.weatherData.wind
            self.sunsetDataLabel.text = self.getData.weatherData.formatedSunsetDate
            self.sunriseDataLabel.text = self.getData.weatherData.formatedSunriseDate
            self.weatherIcon.image = UIImage(named: self.getData.weatherData.weatherIconName)
            self.weatherDescriptionDataLabel.text = self.getData.weatherData.weatherDescription
            self.weatherHumidityDataLabel.text = self.getData.weatherData.weatherHumidity
            
            for i in 0...self.getData.weatherData.forcastArray.count - 1 {
                let forcastImage = self.getData.weatherData.forcastArray[i].weatherIconName
                let forcastTemp = String(self.getData.weatherData.forcastArray[i].temp)
                
                let forcastTime = self.getData.weatherData.forcastArray[i].hour
                self.addForcastView(forcastImage: forcastImage, tempText: forcastTemp, timeText: forcastTime)
                
                // to do : make your own data
                self.addSecondForcastView(forcastImage: forcastImage, tempText: forcastTemp, timeText: forcastTime)
            }
        }
    }
    
    // MARK: - Weather Forcast
    
    func addForcastView(forcastImage: String, tempText: String, timeText: String) {
        
        // Forcast View
        let forcastSize = forcastScrollView.bounds
        let numberOfView = Double(forcastScrollView.subviews.count - 2)
        let forcastHeight = Double(forcastSize.height)
        let position = numberOfView * forcastHeight
        print("position is \(position)")
        let forcastView = UIView(frame: CGRect(x: position, y: 5 , width: forcastHeight, height: forcastHeight))
        
        // Forcast Image
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: forcastHeight / 2, height: forcastHeight / 2)
        imgView.image = UIImage(named: forcastImage)
        imgView.contentMode = .center

        forcastView.addSubview(imgView)

        // Forcast temp label
        let tempLabel = UILabel()
        tempLabel.text = tempText
        tempLabel.frame = CGRect(x: 0, y: 0, width: forcastHeight, height: forcastHeight)
        tempLabel.textAlignment = .center
        forcastView.addSubview(tempLabel)
        
        // Forcast time label
        let timeLabel = UILabel()
        timeLabel.text = timeText
        timeLabel.frame = CGRect(x: 0, y: 0, width: forcastHeight, height: forcastHeight / 3)
        tempLabel.textAlignment = .center
        forcastView.addSubview(timeLabel)
        
        
        //self.forcastScrollView.addSubview(forcastView)
        self.forcastScrollView.alwaysBounceHorizontal = true
    }
    
    func addSecondForcastView(forcastImage: String, tempText: String, timeText: String) {

        // Forcast View
        let forcastSize = secondForcastScrollView.bounds
        let numberOfView = Double(secondForcastScrollView.subviews.count - 2)
        let forcastWidth = Double(forcastSize.width)
        let position = numberOfView * forcastWidth / 4.3
        print("position is \(position)")
        let forcastView = UIView(frame: CGRect(x: 5, y: position , width: forcastWidth, height: forcastWidth / 4.3))
        
        // Forcast Image
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: forcastWidth / 6, height: forcastWidth / 6)
        imgView.image = UIImage(named: forcastImage)
        imgView.contentMode = .center
        forcastView.addSubview(imgView)
        
        // Forcast temp label
        let tempLabel = UILabel()
        tempLabel.text = tempText
        tempLabel.frame = CGRect(x: 0, y: 0, width: forcastWidth, height: forcastWidth)
        tempLabel.textAlignment = .center
        imgView.addSubview(tempLabel)
        
        // Forcast time label
        let timeLabel = UILabel()
        timeLabel.text = timeText
        timeLabel.frame = CGRect(x: 0, y: 0, width: forcastWidth, height: forcastWidth / 3)
        tempLabel.textAlignment = .center
        imgView.addSubview(timeLabel)
      
        //self.secondForcastScrollView.addSubview(forcastView)
        self.secondForcastScrollView.alwaysBounceVertical = true
        
    }

    // do a file with all errors?
    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Reload", style: .default, handler: { (action) -> Void in
                self.getData.startLocation()
            })
            let settings = UIAlertAction(title: "Settings", style: .destructive, handler: { (action) -> Void in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
            alert.addAction(reload)
            alert.addAction(settings)
            self.present(alert, animated: true)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
