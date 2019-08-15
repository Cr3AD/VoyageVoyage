//
//  ViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 23/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, DidUpdateLocation {
    
    // Mark: - IBOutlets
    
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var tempDataLabel: UILabel?
    @IBOutlet weak var weatherDescriptionDataLabel: UILabel?
    @IBOutlet weak var maxTempDataLabel: UILabel?
    @IBOutlet weak var minTempDataLabel: UILabel?
    @IBOutlet weak var windDataLabel: UILabel?
    @IBOutlet weak var sunriseDataLabel: UILabel?
    @IBOutlet weak var sunsetDataLabel: UILabel?
    @IBOutlet weak var weatherHumidityDataLabel: UILabel?
    @IBOutlet weak var forcastScrollView: UIScrollView?
    
    // MARK: - Proprieties
    
    private let locationService = LocationService()
    private var dataWeather: WeatherDataJSON?
    private var dataForcast: ForcastDataJSON?
    
    // MARK - ViewDidLoad
    
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
    }
    
    // MARK: - Download Data for Weather and Forcast
    
    internal func updateWeatherAndForcastDataAtLocation() {
        let lat = String(locationService.latitude)
        let lon = String(locationService.longitude)
        WeatherService.shared.getWeather(lat: lat, lon: lon) { (data, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            self.dataWeather = data
            do {
                try self.updateWeatherDataOnScreen()
                
            } catch let error {
                print(error)
            }
        }
        
        ForcastService.shared.getForcast(lat: lat, lon: lon) { (data, error) in
            guard error == nil else {
                print(error as Any)
                return
            }
            self.dataForcast = data
            do {
                try self.updateForcastDataOnScreen()
            } catch let error {
                print(error)
            }
        }
    }

    // MARK: - Update Data on the screen
    
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
        case noCondition
        case noForcastList
        case noForcastDate
        case noForcastTemp
        case noForcastWind
        case noForcastImage
    }
    
    private func updateWeatherDataOnScreen() throws {
        
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
        
        guard let condition: Int = self.dataWeather?.weather?[0].id else {
            throw updateWeatherDataOnScreenErrors.noCondition
        }
        
        let temperatureFinal = (temperature - 273.15).intValue.string + "°"
        let temperatureMinFinal = (temperatureMin - 273.15).intValue.string + "°"
        let temperatureMaxFinal = (temperatureMax - 273.15).intValue.string + "°"
        let windFinal = (wind).intValue.string +  "kmh"
        let sunriseDateFinal = Date(timeIntervalSince1970: sunriseDate.doubleValue)
        let formatedSunriseDate = dateFormatter.string(from: sunriseDateFinal)
        let sunsetDateFinal = Date(timeIntervalSince1970: sunsetDate.doubleValue)
        let formatedSunsetDate = dateFormatter.string(from: sunsetDateFinal)
        let weatherHumidityFinal = weatherHumidity.string + "%"
        
        if currentDateTime > sunriseDateFinal && currentDateTime < sunsetDateFinal {
            isItDay = true
        } else {
            isItDay = false
        }
        
        let weatherIconName: String = updateWeatherIcon(condition: condition, isDay: isItDay)
        
        self.cityLabel?.text = city
        self.weatherDescriptionDataLabel?.text = weatherDescription
        self.tempDataLabel?.text = temperatureFinal
        self.minTempDataLabel?.text = temperatureMinFinal
        self.maxTempDataLabel?.text = temperatureMaxFinal
        self.windDataLabel?.text = windFinal
        self.sunsetDataLabel?.text = formatedSunsetDate
        self.sunriseDataLabel?.text = formatedSunriseDate
        self.weatherHumidityDataLabel?.text = weatherHumidityFinal
        self.weatherIcon?.image = UIImage(named: weatherIconName)
        
    }
    
    private func updateForcastDataOnScreen() throws {
        do {
            
            guard let forcastList = self.dataForcast?.list else {
                throw updateWeatherDataOnScreenErrors.noForcastList
            }
            
            for i in forcastList {
                
                guard let time = i.dt else {
                    throw updateWeatherDataOnScreenErrors.noForcastDate
                }
                
                guard let forcastImage = i.weather?[0].id else {
                    throw updateWeatherDataOnScreenErrors.noForcastImage
                }
                
                guard let forcastTemp = i.main?.temp else {
                    throw updateWeatherDataOnScreenErrors.noForcastTemp
                }
                
                guard let forcastWind = i.wind?.speed else {
                    throw updateWeatherDataOnScreenErrors.noForcastWind
                }
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat  = "HH:mm"
                let timeFinal = Date(timeIntervalSince1970: time.doubleValue)
                let timeFormated = dateFormatter.string(from: timeFinal)
                let forcastImageFinal = updateWeatherIcon(condition: forcastImage, isDay: true)
                let forcastTempFinal = (forcastTemp - 273.15).intValue.string + "°"
                let windFinal = forcastWind.string + "kmh"
                self.addForcastView(forcastImage: forcastImageFinal, tempText: forcastTempFinal, timeText: timeFormated, wind: windFinal)
            }
        } catch let error {
            print(error)
        }
    }
    
    private func addForcastView(forcastImage: String, tempText: String, timeText: String, wind: String) {
        
        // Forcast View
        let forcastSize = forcastScrollView?.bounds
        let numberOfView = Double(forcastScrollView?.subviews.count ?? 0) - 2
        let forcastHeight: Double = 25
        let forcastWidth = Double(forcastSize?.width ?? 0)
        let position = numberOfView * forcastHeight
        
        let mainStackView = UIStackView(frame: CGRect(x: 0, y: position , width: forcastWidth, height: forcastHeight))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(makeimgView(with: forcastImage))
        mainStackView.addArrangedSubview(makeLabelView(with: tempText))
        mainStackView.addArrangedSubview(makeimgView(with: "wind"))
        mainStackView.addArrangedSubview(makeLabelView(with: wind))
        mainStackView.addArrangedSubview(makeLabelView(with: timeText))
        
        self.forcastScrollView?.addSubview(mainStackView)
        self.forcastScrollView?.alwaysBounceVertical = true
        
    }
    
    private func makeimgView(with image: String) -> UIImageView {
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: image)
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }
    
    private func makeLabelView(with text: String) -> UILabel {
        
        let lblView = UILabel()
        lblView.text = text
        lblView.textAlignment = .center
        
        return lblView
    }
    
    private func updateWeatherIcon(condition: Int, isDay: Bool) -> String {
        
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
}

extension WeatherViewController: ShowErrorMessage {
    func showAlertNoConnectionError(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let reload = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                self.updateWeatherAndForcastDataAtLocation()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {(action) -> Void in
            })
            alert.addAction(reload)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
}

