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
    var context: NSManagedObjectContext { get }
    
    func saveContext()
    func fetchRecipes(completion: @escaping (([LikedFoodCD]) -> Void))
    func deleteRecipe(label: String)
    func fetchRequestIfConsistElement(with label: String) -> Bool 
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
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchRecipes(completion: @escaping (([LikedFoodCD]) -> Void)) {
        let fetchRequest: NSFetchRequest<LikedFoodCD> = LikedFoodCD.fetchRequest()
        
        do {
            let objects = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                completion(objects)
            }
        } catch let error {
            print(error)
        }
    }
    
    func fetchRequestIfConsistElement(with label: String) -> Bool {

        let fetchRequest: NSFetchRequest<LikedFoodCD> = LikedFoodCD.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "recipeName == %@", label as CVarArg)
        fetchRequest.fetchLimit = 1

        do {
            let count = try context.count(for: fetchRequest)

            return count > 0
        } catch let error {
            print(error)
        }

        return false
    }
    
    func deleteRecipe(label: String) {

        let fetheRequest: NSFetchRequest<LikedFoodCD> = LikedFoodCD.fetchRequest()

        fetheRequest.predicate = NSPredicate(format: "recipeName == %@", label as CVarArg)
        
        let context = persistentContainer.viewContext
        
        do {
            let recipes = try context.fetch(fetheRequest)
            for recipe in recipes {
                context.delete(recipe)
            }
            saveContext()
            print("DELETE Success")
        } catch let error {
            print(error)
        }
    }
}


