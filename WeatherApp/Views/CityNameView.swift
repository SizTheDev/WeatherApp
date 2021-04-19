//
//  CityNameView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text(city)
                    .font(.title)
                    .bold()
            }.foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
