//
//  Persistance.swift
//  WeatherApp
//
//  Created by Sizwe on 2021/04/19.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Favourites")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error: \(error)")
            }
        }
    }
}
