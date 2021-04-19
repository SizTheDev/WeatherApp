//
//  MenuHeader.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct MenuHeader: View {
    
    let persistenceContainer = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var locations: FetchedResults<Location>
    
    @ObservedObject var cityVM: CityViewViewModel
   
    @State var showFavourites = false
    @State private var searchTerm = ""
    
    var body: some View {
        HStack {
            HStack {
                TextField("", text: $searchTerm)
                    .padding()
                
                HStack {
                    Button {
                        cityVM.city = searchTerm
                    } label: {
                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.blue.opacity(0.7))
                            
                            Image(systemName: "location.fill")
                        }
                    }
                    .frame(width: 50, height: 50)
                }
                
            }
            .padding(.leading)
            .background(ZStack (alignment: .leading) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(cityVM.getForecastWeatherBackgroundColour(main: cityVM.getCurrentWeatherMain())).opacity(0.5))
        })
            Button {
                addFav()
            } label: {
                ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                    
                    Image(systemName: "plus.square.fill")
                }
            }
            .frame(width: 50, height: 50)
            Button {
                self.showFavourites.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.pink)
                    
                    Image(systemName: "heart.fill")
                }
            }
            .frame(width: 50, height: 50)
            .sheet(isPresented: $showFavourites, content: {
                FavouritesView(cityVM: cityVM)
                    .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
            })
            
        }.foregroundColor(.white)
        
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    private func addFav() {
        let newFav = Location(context: viewContext)
        newFav.title = cityVM.city
        newFav.lat = cityVM.location.latitude
        newFav.lon = cityVM.location.longitude
        saveContext()
    }

}

struct MenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
