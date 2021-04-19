//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

struct WeatherResponse: Codable{
   var current: CurrentWeather
    var forecast: Forecast
    
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: CurrentWeather(), forecast: Forecast())
    }
}
