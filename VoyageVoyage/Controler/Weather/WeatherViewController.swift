//
//  ViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 23/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, DidUpdateLocation, ShowErrorMessage, WeatherData, ForcastData {
    
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
    
    
    let networkService = NetworkService()
    let locationService = LocationService()
    var dataWeather: WeatherJSON?
    var dataForcast: ForcastJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // configure location
        locationService.enableBasicLocationServices()
        
        // Delegate
        delegateSetUp()
    }
    
    private func delegateSetUp() {
        locationService.locationDidUpdateDelegate = self
        networkService.forcastDataDelegate = self
        networkService.weatherDataDelegate = self
    }
    
    func getWeatherDataAtLocation() {
        let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
        let FORCAST_URL = "http://api.openweathermap.org/data/2.5/forecast"
        let weatherAPI = valueForAPIKey(named:"weatherAPI")
        let lat = String(locationService.latitude)
        let lon = String(locationService.longitude)
        networkService.networking(url: "\(WEATHER_URL)?APPID=\(weatherAPI)&lon=\(lon)&lat=\(lat)", requestType: "weather")
        networkService.networking(url: "\(FORCAST_URL)?APPID=\(weatherAPI)&lon=\(lon)&lat=\(lat)&cnt=5", requestType: "forcast")
    }
    
    func receiveWeatherData(_ data: WeatherJSON) {
        self.dataWeather = data
        print("Data weather received")
        print(dataWeather as Any)
        updateWeatherDataOnScreen()
    }
    func receiveForcastData(_ data: ForcastJSON) {
        self.dataForcast = data
        print("Data forcast received")
        print(dataForcast as Any)
        updateWeatherForcastDataOnScreen()
    }
    
    func updateWeatherDataOnScreen() {
        
        let city: String = (self.dataWeather?.name)!
        let weatherDescription: String = (self.dataWeather?.weather?[0].weatherDescription)!
        let temperature: String = "\(Int((self.dataWeather?.main?.temp)! - 273.15))°"
        let temperatureMin: String = "\(Int((self.dataWeather?.main?.tempMin)! - 273.15))°"
        let temperatureMax: String = "\(Int((self.dataWeather?.main?.tempMax)! - 273.15))°"
        let wind: String = "\(Int((self.dataWeather?.wind?.speed)!)) km/h"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH:mm"
        
        let sunriseDate = Date(timeIntervalSince1970: Double((self.dataWeather?.sys?.sunrise)!))
        let sunsetDate = Date(timeIntervalSince1970: Double((self.dataWeather?.sys?.sunset)!))
        let formatedSunriseDate : String = dateFormatter.string(from: sunsetDate)
        let formatedSunsetDate : String = dateFormatter.string(from: sunriseDate)
        
        let weatherHumidity: String = String("\((self.dataWeather?.main?.humidity)!)")
        
        let currentDateTime = Date()
        var isItDay : Bool
        
        if currentDateTime > sunriseDate && currentDateTime < sunsetDate {
            isItDay = true
        } else {
            isItDay = false
        }
        
        let condition: Int = (self.dataWeather?.weather![0].id)!
        let weatherIconName: String = updateWeatherIcon(condition: condition, isDay: isItDay)
        
        
        DispatchQueue.main.sync {
            
            self.cityLabel.text = city
            self.weatherDescriptionDataLabel.text = weatherDescription
            self.tempDataLabel.text = temperature
            self.minTempDataLabel.text = temperatureMin
            self.maxTempDataLabel.text = temperatureMax
            self.windDataLabel.text = wind
            self.sunsetDataLabel.text = formatedSunsetDate
            self.sunriseDataLabel.text = formatedSunriseDate
            self.weatherHumidityDataLabel.text = weatherHumidity
            self.weatherIcon.image = UIImage(named: weatherIconName)
            
        }
    }
    
    func updateWeatherIcon(condition: Int, isDay: Bool) -> String {
        
        switch (condition) {
            
        case 200...300 :
            return "thunderstorm"
        case 301...600 :
            if isDay == true {
                return "rainday"
            } else {
                return "rainnight"
            }
            
        case 501...600 :
            return "rainnight"
            
        case 601...700 :
            if isDay == true {
                return "snowday"
            } else {
                return "snownight"
            }
            
        case 701...771 :
            if isDay == true {
                return "fogday"
            } else {
                return "fognight"
            }
            
        case 781...799 :
            return "wind"
            
        case 800 :
            if isDay == true {
                return "sunny"
            } else {
                return "moon"
            }
            
        case 801...802 :
            if isDay == true {
                return "cloudday"
            } else {
                return "cloudnight"
            }
            
        case 803...804 :
            return "cloudnight"
            
        default :
            if isDay == true {
                return "sunny"
            } else {
                return "moon"
            }
        }
        
    }
    
    func updateWeatherForcastDataOnScreen() {
        
        DispatchQueue.main.sync {
            for i in (self.dataForcast?.list)! {
                
                let forcastImage = updateWeatherIcon(condition: i.weather![0].id!, isDay: true)

                let forcastTemp = "\(Int(i.main!.temp! - 273.15))°"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat  = "HH:mm"
                
                let time = Date(timeIntervalSince1970: Double((i.dt!)))
                //let formatedTime = String(time)
                    
                self.addForcastView(forcastImage: forcastImage, tempText: forcastTemp, timeText: "")

                
//                // to do : make your own data
//                self.addSecondForcastView(forcastImage: forcastImage, tempText: forcastTemp, timeText: forcastTime)
            }
        }
    }
    
    // MARK: - Weather Forcast
    
        func addForcastView(forcastImage: String, tempText: String, timeText: String) {
    
            // Forcast View
            let forcastSize = forcastScrollView.bounds
            let numberOfView = Double(forcastScrollView.subviews.count)
            let forcastHeight = Double(forcastSize.height)
            let position = numberOfView * forcastHeight + 5
            print("position is \(position)")
            let forcastView = UIView(frame: CGRect(x: position, y: 5 , width: forcastHeight, height: forcastHeight))
    
            // Forcast Image
            
            
            
            
            let imgView = UIImageView()
            imgView.frame = CGRect(x: 0, y: 0, width: forcastHeight / 2, height: forcastHeight / 2)
            imgView.image = UIImage(named: forcastImage)
            imgView.contentMode = .scaleAspectFit
    
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
    
    
            self.forcastScrollView.addSubview(forcastView)
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
    
    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                //
            })
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alert.addAction(reload)
            alert.addAction(cancel)
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









