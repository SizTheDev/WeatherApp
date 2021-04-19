//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct ContentView: View {
    
    let persistenceContainer = PersistenceController.shared
    
    @ObservedObject var cityVM = CityViewViewModel()
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        MenuHeader(cityVM: cityVM)
                            .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
                            .padding()
                        CityView(cityVM: cityVM)
                    }.padding(.top,30)
                }.background(
                    Image(cityVM.getCurrentWeatherBackground(main: cityVM.getCurrentWeatherMain()))
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )
                VStack {
                    CurrentWeatherDetail(cityVM: cityVM).padding(.top, 10)
                    Color.white.frame(height: 1)
                    ScrollView(showsIndicators: false) {
                        ForecastView(cityVM: cityVM)
                    }
                }.background(Color(cityVM.getForecastWeatherBackgroundColour(main: cityVM.getCurrentWeatherMain())))
                .edgesIgnoringSafeArea(.all)
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
