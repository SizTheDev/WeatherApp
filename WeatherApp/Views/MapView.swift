//
//  MapView.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/19.
//

import SwiftUI
import MapKit
import Combine

struct Annotation: Identifiable {
    var id = UUID()
    let latitude: Double
    let longitude: Double
}

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: [])
    private var locations: FetchedResults<Location>
    
    @ObservedObject var cityVM: CityViewViewModel
    @State private var region = MKCoordinateRegion.defaultRegion
    
    @State private var annotations = [Annotation]()
    
    private func loadAnnotations() {
        
        for location in locations {
            annotations.append(Annotation(latitude: location.lat, longitude: location.lon))
        }
        
    }
    
    private func setRegion() {
        region = MKCoordinateRegion(center: cityVM.locationManager.location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
    }
    
    var body: some View {
     
            Text("Close")
                .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                .foregroundColor(.black)
            
                VStack {
                    Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: annotations) { annotation in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude)) {
                            Image(systemName: "heart.fill").foregroundColor(.pink)
                        }
                    }
                        
                    }
                    .onAppear {
                        setRegion()
                        loadAnnotations()
                }
            
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
