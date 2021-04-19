//
//  FavouritesView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/18.
//

import SwiftUI

struct FavouritesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: [])
    private var locations: FetchedResults<Location>
    
    @ObservedObject var cityVM: CityViewViewModel
    
    @State var showMap = false
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some View {
        NavigationView {
            List {
                Button {
                    self.showMap.toggle()
                } label: {
                    ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                        
                        Image(systemName: "map.fill")
                    }
                }
                .sheet(isPresented: $showMap, content: {
                    MapView(cityVM: cityVM)
                        .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
                })
                
                ForEach(locations) { location in
                    Text(location.title ?? "Untitled")
                        .foregroundColor(.black)
                        .onTapGesture {
                            cityVM.city = location.title ?? "Pretoria"
                            self.presentationMode.wrappedValue.dismiss()
                        }
    
                }.onDelete(perform: deleteLocation)
            }
            .navigationTitle(Text("Favourits"))
        }
    }
    
    private func deleteLocation(offsets: IndexSet) {
        withAnimation {
            offsets.map { locations[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved Error: \(error)")
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
