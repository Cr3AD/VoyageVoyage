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
    // Connect the code and the UI
    
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
    
    private let locationService = LocationService.shared
    private let weatherService = WeatherService.shared
    private let forcastService = ForcastService.shared
    private var dataWeather: WeatherDataJSON?
    private var dataForcast: ForcastDataJSON?
    private var citySearch = CitySearch()
    
    // MARK - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Delegate setup
        delegateSetUp()
        // Notify when the app wake up from background to update the location
        NotificationCenter.default.addObserver(self, selector: #selector(wakeupApp), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // Object called from the notification wakeupApp from the viewDidLoad
    @objc func wakeupApp() {
        locationService.enableBasicLocationServices()
    }
    
    // Delegate setup
    private func delegateSetUp() {
        // used to call updateWeatherAndForcastDataAtLocation
        locationService.locationDidUpdateDelegate = self
        
        // error messages
        weatherService.errorMessageDelegate = self
        forcastService.errorMessageDelegate = self
    }
    
    // MARK: - Update Data on the screen
    
    // Error enumeration
    enum updateWeatherDataOnScreenErrors: Error {
        // errors for weather
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
        
        // errors for forcast
        case noForcastList
        case noForcastDate
        case noForcastTemp
        case noForcastWind
        case noForcastImage
        case noForcastRain
    }
    
    // Update weather data on screen. Called from protocol DidUpdateLocation
    private func updateWeatherDataOnScreen() throws {
        
        // format the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "HH:mm"
        let currentDateTime = Date()
        
        // used to check if it is night to change the weather icon
        var isItDay : Bool
       
        
        // guard to check the data in dataWeather
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
        
        // format the data in dataWeather to display on the screen
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
        
        // update the weather icon
        let weatherIconName: String = updateWeatherIcon(condition: condition, isDay: isItDay, type: "Weather")
        
        // put the weather data on the screen
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
        // remove the view in the forcastScrollView if the data are refreshed
        self.forcastScrollView?.subviews.forEach({ $0.removeFromSuperview() })
        
        do {
            // check the data in dataForcast
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
                
                // format the data from forcastData to be displayed
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat  = "HH:mm"
                let timeFinal = Date(timeIntervalSince1970: time.doubleValue)
                let timeFormated = dateFormatter.string(from: timeFinal)
                let forcastImageFinal = updateWeatherIcon(condition: forcastImage, isDay: true, type: "Forcast")
                let forcastTempFinal = (forcastTemp - 273.15).intValue.string + "°"
                let windFinal = forcastWind.string + "kmh"
                
                // make the forcat view
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
        
        // create a view to contain the subviews
        let mainStackView = UIStackView(frame: CGRect(x: 0, y: position , width: forcastWidth, height: forcastHeight))
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        
        // add subViews to the mainStack view
        mainStackView.addArrangedSubview(makeLabelView(with: timeText))
        mainStackView.addArrangedSubview(makeimgView(with: forcastImage))
        mainStackView.addArrangedSubview(makeLabelView(with: tempText))
        mainStackView.addArrangedSubview(makeLabelView(with: wind))
        
        // add the main stack view to the forcast scroll view
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
        var completion: String {
            if isDay == true {
                return "Day\(type)"
            } else {
                return "Night\(type)"
            }
        }
        
        switch (condition) {
            
        case 200, 201, 230 :
            return "thunder\(completion)"
        case 202...229, 231...299:
            return "thunder\(type)"
        case 300, 301, 310, 311 :
            return "drizzle\(completion)"
            
        case 302...309, 312...399:
            return "drizzle\(type)"
        case 500, 501, 505...599 :
            return "rain\(completion)"
        case 502...504, 522, 531:
            return "rain\(type)"
        case 600, 601, 603...612, 614...620, 623...699 :
            return "snow\(completion)"
        case 602, 613, 621, 622:
            return "snow\(type)"
        case 700...799 :
            return "fog\(type)"
        case 800 :
            return "clear\(completion)"
        case 801...802 :
            return "cloud\(completion)"
        case 803...804 :
            return "cloud\(type)"
        default :
            return "clear\(completion)"
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
        print("let's update weather data for \(lat) and \(lon)")
        
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
