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
    var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static let sharedInstance = DataManager()
    
    var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var dataFileUrl: URL {
        return documentDirectory.appendingPathComponent("lists").appendingPathExtension("json")
    }
    
    var cachedItems = Array<Item>()
    
    private init() {
        loadListItems()
    }
    
    func filter(searchText: String) -> Array<Item>{
        return DataManager.sharedInstance.cachedItems.filter({( item : Item) -> Bool in
            return item.name!.lowercased().contains(searchText.lowercased())
        })
    }
    
    func delete(item: Item) {
        if let index = cachedItems.index(where:{ (anItem) -> Bool in
            return (anItem === item)
        }) {
            cachedItems.remove(at: index)
        }
        context.delete(item)
        saveListItems()
    }
    
    func saveListItems(){
        saveContext()
    }
    
    func loadItems(with text: String) -> [Item] {
        var items: [Item]! = nil
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        if text.count > 0 {
            let predicate = NSPredicate(format: "name contains[cd] %", text)
            fetchRequest.predicate = predicate
        }
        do {
            items = try context.fetch(fetchRequest)
        } catch {
            debugPrint("Could not load the items from CoreData")
        }
        return items
    }
    
    func loadListItems(){
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            cachedItems = try context.fetch(fetchRequest)
        } catch {
            debugPrint("Could not load the items from CoreData")
        }
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
    
}   
