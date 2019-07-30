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
        try! updateWeatherDataOnScreen()
    }
    func receiveForcastData(_ data: ForcastJSON) {
        self.dataForcast = data
        print("Data forcast received")
        print(dataForcast as Any)
        try! updateWeatherForcastDataOnScreen()
    }
    
    enum updateWeatherDataOnScreenErrors: Error {
        case noCity
        case noWeatherDescription
        case noTemperature
        case noTemperatureMin
        case noTemperatureMax
        case noWind
        case noSunriseDate
        case noSunsetDate
        case noHumidity
        case noForcastList
        case noForcastDate
        case noForcastTemp
        case noForcastWind
        case noForcastImage
    }
    
    func updateWeatherDataOnScreen() throws {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH:mm"
        let currentDateTime = Date()
        var isItDay : Bool
        
        guard let city: String = self.dataWeather?.name else {
            throw updateWeatherDataOnScreenErrors.noCity
        }
        guard let weatherDescription: String = self.dataWeather?.weather?[0].weatherDescription else {
            throw updateWeatherDataOnScreenErrors.noWeatherDescription
        }
        guard let temperature: Double = self.dataWeather?.main?.temp else {
            throw updateWeatherDataOnScreenErrors.noTemperature
        }
        guard let temperatureMin: Double = self.dataWeather?.main?.tempMin else {
            throw updateWeatherDataOnScreenErrors.noTemperatureMin
        }
        guard let temperatureMax: Double = self.dataWeather?.main?.tempMax else {
            throw updateWeatherDataOnScreenErrors.noTemperatureMax
        }
        guard let wind: Double = self.dataWeather?.wind?.speed else {
            throw updateWeatherDataOnScreenErrors.noWind
        }
        guard let sunriseDate: Int = self.dataWeather?.sys?.sunrise else {
            throw updateWeatherDataOnScreenErrors.noSunriseDate
        }
        guard let sunsetDate: Int = self.dataWeather?.sys?.sunset else {
            throw updateWeatherDataOnScreenErrors.noSunsetDate
        }
        
        guard let weatherHumidity: Int = self.dataWeather?.main?.humidity else {
            throw updateWeatherDataOnScreenErrors.noHumidity
        }
        
        let temperatureFinal: String = ("\(Int(temperature - 273.15))°")
        let temperatureMinFinal: String = "\(Int(temperatureMin - 273.15))°"
        let temperatureMaxFinal: String = "\(Int(temperatureMax - 273.15))°"
        let windFinal: String = "\(Int(wind)) km/h"
        let sunriseDateFinal = Date(timeIntervalSince1970: Double(sunriseDate))
        let formatedSunriseDate : String = dateFormatter.string(from: sunriseDateFinal)
        let sunsetDateFinal = Date(timeIntervalSince1970: Double(sunsetDate))
        let formatedSunsetDate : String = dateFormatter.string(from: sunsetDateFinal)
        let weatherHumidityFinal : String = String("\(weatherHumidity)%")
        
        if currentDateTime > sunriseDateFinal && currentDateTime < sunsetDateFinal {
            isItDay = true
        } else {
            isItDay = false
        }
        
        let condition: Int = (self.dataWeather?.weather![0].id)!
        let weatherIconName: String = updateWeatherIcon(condition: condition, isDay: isItDay)
        
        
        DispatchQueue.main.sync {
            
            self.cityLabel.text = city
            self.weatherDescriptionDataLabel.text = weatherDescription
            self.tempDataLabel.text = temperatureFinal
            self.minTempDataLabel.text = temperatureMinFinal
            self.maxTempDataLabel.text = temperatureMaxFinal
            self.windDataLabel.text = windFinal
            self.sunsetDataLabel.text = formatedSunsetDate
            self.sunriseDataLabel.text = formatedSunriseDate
            self.weatherHumidityDataLabel.text = weatherHumidityFinal
            self.weatherIcon.image = UIImage(named: weatherIconName)
            
        }
    }
    
    func updateWeatherForcastDataOnScreen() throws {
        try! DispatchQueue.main.sync {
            
            guard let forcastList = self.dataForcast?.list else {
                throw updateWeatherDataOnScreenErrors.noForcastList
            }
            
            for i in forcastList {
                
                guard let time = i.dt else {
                    throw updateWeatherDataOnScreenErrors.noForcastDate
                }
                
                guard let forcastImage = i.weather![0].id else {
                    throw updateWeatherDataOnScreenErrors.noForcastImage
                }
                
                guard let forcastTemp = i.main!.temp else {
                    throw updateWeatherDataOnScreenErrors.noForcastTemp
                }
                
                guard let forcastWind = i.wind?.speed else {
                    throw updateWeatherDataOnScreenErrors.noForcastWind
                }
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat  = "HH:mm"
                let timeFinal: Date = Date(timeIntervalSince1970: Double(time))
                let timeFormated : String = dateFormatter.string(from: timeFinal)
                let forcastImageFinal = updateWeatherIcon(condition: forcastImage, isDay: true)
                let forcastTempFinal: String = "\(Int(forcastTemp - 273.15))°"
                let windFinal: String = "\(forcastWind) km/h"

                print("second forcast added")
                self.addSecondForcastView(forcastImage: forcastImageFinal, tempText: forcastTempFinal, timeText: timeFormated, wind: windFinal)
                
            }
        }
    }
    
    func addSecondForcastView(forcastImage: String, tempText: String, timeText: String, wind: String) {
        
        // Forcast View
        let forcastSize = secondForcastScrollView.bounds
        let numberOfView = Double(secondForcastScrollView.subviews.count) - 2
        let forcastHeight: Double = 25
        let forcastWidth = Double(forcastSize.width)
        let position = numberOfView * forcastHeight
        print("position is \(position)")
        
        let mainStackView = UIStackView(frame: CGRect(x: 0, y: position , width: forcastWidth, height: forcastHeight))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
       
        
        // Forcast Image
        
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: forcastHeight / 2, height: forcastHeight / 2)
        imgView.image = UIImage(named: forcastImage)
        imgView.contentMode = .scaleAspectFit
        mainStackView.addArrangedSubview(imgView)
        
        // Forcast temp label
        let tempLabel = UILabel()
        tempLabel.text = tempText
        tempLabel.frame = CGRect(x: 0, y: 0, width: forcastHeight, height: forcastHeight)
        tempLabel.textAlignment = .center
        mainStackView.addArrangedSubview(tempLabel)
        
        // Forcast wind Image
        let windImage = UIImageView()
        windImage.frame = CGRect(x: 0, y: 0, width: forcastHeight / 3, height: forcastHeight / 3)
        windImage.image = UIImage(named: "wind")
        windImage.contentMode = .scaleAspectFit
        mainStackView.addArrangedSubview(windImage)
        
        // Forcast wind label
        let windLabel = UILabel()
        windLabel.text = wind
        windLabel.frame = CGRect(x: 0, y: 0, width: forcastHeight, height: forcastHeight)
        windLabel.textAlignment = .right
        mainStackView.addArrangedSubview(windLabel)
        
        // Forcast time label
        let timeLabel = UILabel()
        timeLabel.text = timeText
        timeLabel.frame = CGRect(x: 0, y: 0, width: forcastHeight, height: forcastHeight / 3)
        timeLabel.textAlignment = .center
        mainStackView.addArrangedSubview(timeLabel)
        
        self.secondForcastScrollView.addSubview(mainStackView)
        self.secondForcastScrollView.alwaysBounceVertical = true
        
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












