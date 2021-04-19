//
//  Weather.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

struct Weather: Codable, Identifiable {
    var dt: Int
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var weather: [WeatherDetail]

    enum CodingKey: String {
        case dt
        case temp
        case temp_min
        case temp_max
        case weather
    }
    
    init() {
        dt = 0
        temp = 0.0
        temp_min = 0.0
        temp_max = 0.0
        weather = []
    }
}

extension Weather {
    var id: UUID {
        return UUID()
    }
}
