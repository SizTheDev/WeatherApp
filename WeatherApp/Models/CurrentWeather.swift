//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

struct CurrentWeather: Codable, Identifiable {
    
    var dt: Int
    var main: Main
    var weather: [WeatherDetail]
    
    enum CodingKey: String {
    case dt
    case main
    case weather
    }
    
    init() {
        dt = 0
        main = Main()
        weather = []
    }
}

extension CurrentWeather {
    var id: UUID {
        return UUID()
}
}
