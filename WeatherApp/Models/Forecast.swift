//
//  Forecast.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

struct Forecast: Codable {
    
    var list: [CurrentWeather]
    
    enum CodingKey: String {
    case list
    }
    
    init() {
        list = []
    }
    
}


