//
//  CurrentWeatherDetail.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct CurrentWeatherDetail: View {
    
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        HStack {
            VStack {
                Text("\(cityVM.min)°")
                    .bold()
                Text("min")
            }
            .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            VStack {
                Text("\(cityVM.temperature)°")
                    .bold()
                Text("Current")
            }
            .frame(width: 100)
            
            Spacer()
            
            VStack {
                Text("\(cityVM.max)°")
                    .bold()
                Text("max")
            }
            .frame(width: 100, alignment: .trailing)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 10)
        //.padding(.vertical, 15)
    }
}

struct CurrentWeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
