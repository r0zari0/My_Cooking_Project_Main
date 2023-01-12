//
//  CoreDataStore.swift
//  My_Cooking_Project
//
//  Created by Max Stovolos on 1/10/23.
//

import Foundation
import CoreData

// MARK: - Protocol

protocol CoreDataStoreProtocol {
    
}

// MARK: - CoreDataStore

class CoreDataStore: CoreDataStoreProtocol {
    
    // MARK: - Core Data stack
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "My_Cooking_Project")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
