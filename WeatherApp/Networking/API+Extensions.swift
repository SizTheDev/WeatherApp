//
//  API+Extensions.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

extension API {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLFor(lat: Double, lon: Double, callType: String) -> String {
        return "\(baseURLString)\(callType)lat=\(lat)&lon=\(lon)&appid=\(key)&units=metric"
    }
    
}
