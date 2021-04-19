//
//  Main.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import Foundation

struct Main: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    
    init() {
        temp = 0.0
        temp_min = 0.0
        temp_max = 0.0
    }
}
