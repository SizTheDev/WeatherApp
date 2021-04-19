//
//  CityViewViewModel.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import CoreLocation
import SwiftUI

final class CityViewViewModel: NSObject, ObservableObject{
    @Published var weather = WeatherResponse.empty()
    
    @Published var city: String = "" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, h:mm a"
        return formatter
    }()
    
    public let locationManager = CLLocationManager()
    public var location = CLLocationCoordinate2D()
    
    
    
    public override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    let currWeather = "weather?"
    let forecastWeather = "forecast?"
    
    var day: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "clear"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.main.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main.uppercased()
        }
        return ""
    }
    
    var min: String {
        return getTempFor(temp: weather.current.main.temp_min)
    }
    
    var max: String {
        return getTempFor(temp: weather.current.main.temp_max)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.f", temp)
    }
    
    private func getLocation() {
        if (city.isEmpty){
            locationManager.startUpdatingLocation()
        } else {
            CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
                if let places = placemarks, let place = places.first {
                    self.getCurrentWeather(coord: place.location?.coordinate)
                    self.getForecast(coord: place.location?.coordinate)
                    self.location = place.location!.coordinate
                }
            }
        }
        
    }
    
    private func getLocation(forCoordinates coordinates: CLLocationCoordinate2D) {
        self.getCurrentWeather(coord: coordinates)
        self.getForecast(coord: coordinates)
        location = coordinates
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.city = place.locality!
            }
        }
    }
    
    private func getCurrentWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude, callType: currWeather)
            getCurrentWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9866, callType: currWeather)
            getCurrentWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getForecast(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude, callType: forecastWeather)
            getForecastWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9866, callType: forecastWeather)
            getForecastWeatherInternal(city: city, for: urlString)
        }
    }
    
    
    private func getForecastWeatherInternal(city: String, for urlString: String) {
        NetworkManager<Forecast>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather.forecast = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func getCurrentWeatherInternal(city: String, for urlString: String) {
        NetworkManager<CurrentWeather>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather.current = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getCurrentWeatherMain() -> String {
        if (!weather.current.weather.isEmpty) {
            return weather.current.weather[0].main
        } else {
            return "Clear"
        }
    }
    
    func getCurrentWeatherBackground(main: String) -> String {
        switch main {
        case "Clear":
            return "forest_sunny"
        case "Clouds":
            return "forest_cloudy"
        default:
            return "forest_Rainy"
        }
    }
    
    func getForecastWeatherBackgroundColour(main: String) -> String {
        switch main {
        case "Clear":
            return "SUNNY"
        case "Clouds":
            return "CLOUDY"
        default:
            return "RAINY"
        }
    }
    
    
    func getForecastIcon(main: String) -> String {
        switch main {
        case "Clear":
            return "clear"
        case "Clouds":
            return "partlysunny"
        default:
            return "rain"
        }
    }
    
    
}

extension CityViewViewModel: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        getLocation(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong:  \(error.localizedDescription)")
    }
}
