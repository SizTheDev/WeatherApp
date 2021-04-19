//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct ForecastView: View {
    
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        ForEach(cityVM.weather.forecast.list) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            }
        }
    }
    
    private func dailyCell(weather: CurrentWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt).capitalized)
                .frame(width: 100)
            
            Spacer()
            
            Image(cityVM.getForecastIcon(main: weather.weather[0].main))
                .resizable()
                .frame(width: 30, height: 30)
            Spacer()
            
            Text("\(cityVM.getTempFor(temp: weather.main.temp))°")
                .frame(width: 50)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
    }
       
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
