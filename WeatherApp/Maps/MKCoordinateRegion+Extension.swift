//
//  MKCoordinateRegion+Extension.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/19.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: -25.849682, longitude: 28.124481), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
