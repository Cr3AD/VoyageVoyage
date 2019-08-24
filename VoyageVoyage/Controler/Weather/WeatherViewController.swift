//
//  ViewController.swift
//  VoyageVoyage
//
//  Created by Cr3AD on 23/05/2019.
//  Copyright © 2019 Cr3AD. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
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
    private let weatherService = WeatherService.shared
    private let forcastService = ForcastService.shared
    private var dataWeather: WeatherDataJSON?
    private var dataForcast: ForcastDataJSON?
    
    // MARK - ViewDidLoad
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Delegate
        delegateSetUp()
        // configure location
        locationService.enableBasicLocationServices()
        // Notify when the app wake up from background to update the location
        NotificationCenter.default.addObserver(self, selector: #selector(wakeupApp), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // Object called from the notification wakeupApp from the viewDidLoad
    @objc func wakeupApp() {
        self.forcastScrollView?.subviews.forEach({ $0.removeFromSuperview() })
        locationService.enableBasicLocationServices()
    }
    
    // Delegate setup
    private func delegateSetUp() {
        locationService.locationDidUpdateDelegate = self
        weatherService.errorMessageDelegate = self
        forcastService.errorMessageDelegate = self
    }
    
    
    // MARK: - Update Data on the screen
    
    // Error enumeration
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
    
    // Update weather data on screen. Called from protocol DidUpdateLocation
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
        
        let weatherIconName: String = updateWeatherIcon(condition: condition, isDay: isItDay, type: "Weather")
        
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
    
    // Update weather forecast data on screen. Called from protocol DidUpdateLocation
    private func updateForcastDataOnScreen() throws {
        for view in self.forcastScrollView!.subviews {
            view.removeFromSuperview()
            print("removed \(view)")
        }
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
                let forcastImageFinal = updateWeatherIcon(condition: forcastImage, isDay: true, type: "Forcast")
                let forcastTempFinal = (forcastTemp - 273.15).intValue.string + "°"
                let windFinal = forcastWind.string + "kmh"
                self.makeForcatView(forcastImage: forcastImageFinal, tempText: forcastTempFinal, timeText: timeFormated, wind: windFinal)
                
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    // Make forcastView
    private func makeForcatView(forcastImage: String, tempText: String, timeText: String, wind: String) {
        
        // Forcast View
        let forcastSize = forcastScrollView?.bounds
        let numberOfView = Double(forcastScrollView?.subviews.count ?? 0)
        let forcastHeight: Double = 35
        let forcastWidth = Double(forcastSize?.width ?? 0)
        let position = numberOfView * forcastHeight
        
        let mainStackView = UIStackView(frame: CGRect(x: 0, y: position , width: forcastWidth, height: forcastHeight))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(makeLabelView(with: timeText))
        mainStackView.addArrangedSubview(makeimgView(with: forcastImage))
        mainStackView.addArrangedSubview(makeLabelView(with: tempText))
//        mainStackView.addArrangedSubview(makeimgView(with: "wind"))
        mainStackView.addArrangedSubview(makeLabelView(with: wind))
        
        
        self.forcastScrollView?.addSubview(mainStackView)
        self.forcastScrollView?.alwaysBounceVertical = true
        
    }
    
    // Make imageView for forcastView
    private func makeimgView(with image: String) -> UIImageView {
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: image)
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }
    
    // Make labelView for forcastView
    private func makeLabelView(with text: String) -> UILabel {
        
        let lblView = UILabel()
        lblView.text = text
        lblView.textAlignment = .center
        
        return lblView
    }
    
    // Weather icon selection
    private func updateWeatherIcon(condition: Int, isDay: Bool, type: String) -> String {
        
        switch (condition) {
            
        case 200, 201, 230 :
            if isDay == true {
                return "thunderDay\(type)"
            } else {
                return "thunderNight\(type)"
            }
        case 202...229, 231...299:
            return "thunder\(type)"
        
            
        case 300, 301, 310, 311 :
            if isDay == true {
                return "drizzleDay\(type)"
            } else {
                return "drizzleNight\(type)"
            }
        case 302...309, 312...399:
            return "drizzle\(type)"
            
        case 500, 501, 505...599 :
            if isDay == true {
                return "rainDay\(type)"
            } else {
                return "rainNight\(type)"
            }
            
        case 502...504, 522, 531:
            return "rain\(type)"
            
        case 600, 601, 603...612, 614...620, 623...699 :
            if isDay == true {
                return "snowDay\(type)"
            } else {
                return "snowNight\(type)"
            }
        case 602, 613, 621, 622:
            return "snow\(type)"
            
        case 700...799 :
            return "fog\(type)"
            
//        case 781...799 :
//            return "wind"
            
        case 800 :
            if isDay == true {
                return "clearDay\(type)"
            } else {
                return "clearNight\(type)"
            }
            
        case 801...802 :
            if isDay == true {
                return "cloudDay\(type)"
            } else {
                return "cloudNight\(type)"
            }
            
        case 803...804 :
            return "cloud\(type)"
            
        default :
            if isDay == true {
                return "clearDay\(type)"
            } else {
                return "clearNight\(type)"
            }
        }
        
    }
}

extension WeatherViewController: ShowErrorMessage {
    func showAlertNoConnectionError(title: String, message: String) {
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
extension WeatherViewController: DidUpdateLocation {
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
    
    internal func showUserNoLocationAvailable() {
        self.cityLabel!.text = "Error"
        self.weatherDescriptionDataLabel!.text = "No Location Authorised"
        self.weatherIcon!.isHidden = true
    }
}
