//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("\(cityVM.temperature)°")
                .font(.largeTitle)
                .bold()
            Text("\(cityVM.conditions)")
                .font(.title)
                .bold()
            Spacer()
        }
        .foregroundColor(.white)
    }
    
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
