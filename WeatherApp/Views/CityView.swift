//
//  CityView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct CityView: View {
    
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
            VStack {
                    Spacer()
                    CityNameView(city: cityVM.city)
                    Spacer()
                    CurrentWeatherView(cityVM: cityVM)
            }
       
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
