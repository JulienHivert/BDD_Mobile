//
//  DataManager.swift
//  iOS_BDD_Do_It
//
//  Created by iem on 30/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation
import CoreData
class DataManager {
    static let sharedInstance = DataManager()
    lazy var cachedItems = Array<Item>()
    //Demande de William pour rendre le code plus maintenable et réutilisable.
    lazy var cachedCategories = Array<Categorie>()
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("lists").appendingPathExtension("json")
    }
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //var cachedItems = Array<Item>()
    
    private init() {
        loadListItems()
        initCategories()
    }
    
    func filter(searchText: String) -> Array<Item>{
        return DataManager.sharedInstance.cachedItems.filter({( item : Item) -> Bool in
            return item.name!.lowercased().contains(searchText.lowercased())
        })
    }
    
    func delete(item : Item){
        context.delete(item)
        if let index = cachedItems.index(where : { (anItem) -> Bool in
            return(anItem === item)
        }){
            cachedItems.remove(at: index)
        }
        context.delete(item)
        saveListItems()
    }
    
    func saveListItems(){
        saveContext()
    }
    func initCategories() {
        let cat1 = Categorie(context: context)
        cat1.name = "orange"
        cachedCategories.append(cat1)
        
        let cat2 = Categorie(context: context)
        cat2.name = "yellow"
        cachedCategories.append(cat2)
        
        let cat3 = Categorie(context: context)
        cat3.name = "green"
        cachedCategories.append(cat3)
        
        let cat4 = Categorie(context: context)
        cat4.name = "purple"
        cachedCategories.append(cat4)
        
        let cat5 = Categorie(context: context)
        cat5.name = "blue"
        cachedCategories.append(cat5)
        
        let cat6 = Categorie(context: context)
        cat6.name = "black"
        cachedCategories.append(cat6)
    }
    
    func loadListItems( with text: String? = ""){
//        var items : [Item]! = nil
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        if text != nil, text!.count > 0 {
            let predicate = NSPredicate(format : "name containers[cd] %@", text!)
            fetchRequest.predicate = predicate
    }
        do{
            cachedItems = try context.fetch(fetchRequest)
        }catch{
            debugPrint("could not load the items from CoreData")
        }
//        return items
    }
 
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iOS_BDD_Do_it")
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}   
