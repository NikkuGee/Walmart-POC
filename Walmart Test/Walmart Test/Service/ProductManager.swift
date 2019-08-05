//
//  ProductManager.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ProductManager {
    
    static let shared = ProductManager()
    private init() {}
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //MARK: Context to save to Core Data
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: Perisistent Container initializer
    lazy var persistentContainer: NSPersistentContainer = {
        objc_sync_enter(self)
        
        let container = NSPersistentContainer(name: "Walmart_Test")
        
        container.loadPersistentStores(completionHandler: { (store, err) in
            if let error = err {
                fatalError()
            }
        })
        objc_sync_exit(self)
        return container
    }()
    
    //MARK: Save Order
    func saveOrder(_ product: Product){
        
        //create an entity description
        let entity = NSEntityDescription.entity(forEntityName: "Productz", in: context)!

        //initialize an entity
        let nProduct = NSManagedObject(entity: entity, insertInto: context)

        //check if product is already in core data
        let count = checkCore(name: product.name)
        if count > 0 {
            remove(id: product.id)
            nProduct.setValue(NSNumber(value: product.id), forKey: "id")
            nProduct.setValue(product.name, forKey: "name")
            nProduct.setValue(product.picture, forKey: "picture")
            nProduct.setValue(product.price, forKey: "price")
            nProduct.setValue(NSNumber(value: count + 1), forKey: "count")
        } else {
            nProduct.setValue(NSNumber(value: product.id), forKey: "id")
            nProduct.setValue(product.name, forKey: "name")
            nProduct.setValue(product.picture, forKey: "picture")
            nProduct.setValue(product.price, forKey: "price")
            nProduct.setValue(NSNumber(value: product.countz + 1), forKey: "count")
        }
        
        
    
        
      
        //save the context
        saveContext()
    }
    
    //MARK: Check if order already exists
    func checkCore(name: String) -> Int{
        let fetchRequest = NSFetchRequest<Productz>(entityName: "Productz")
        let predicate = NSPredicate(format: "name==%@", name)
        
        fetchRequest.predicate = predicate
        var prods = [Productz]()
        do {
            prods = try context.fetch(fetchRequest)
            if prods.count > 0 {
                return Int(prods[0].count)
            } else {
                return 0
            }
        } catch {
            print("Couldn't fetch products: \(error.localizedDescription)")
            return 0
        }
    }
    
    //MARK: Remove Order to set new count
    func remove(id: Int) {
        
        let fetchRequest = NSFetchRequest<Productz>(entityName: "Productz")
        let predicate = NSPredicate(format: "id==%@", NSNumber(value: id))
        
        fetchRequest.predicate = predicate
        var prods = [Productz]()
        do {
            prods = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch products: \(error.localizedDescription)")
        }
        
        for pr in prods {
            
            context.delete(pr)
        }
        
        saveContext()
    }
    
    func load() -> [Product] {
        let fetchRequest = NSFetchRequest<Productz>(entityName: "Productz")
        
        
        do {
            let prodz = try context.fetch(fetchRequest)
            let prods = prodz.map({Product(from: $0)})
            return prods
        } catch {
            print("Couldn't load products: \(error.localizedDescription)")
        }
        
        return []
    }
    
    //MARK: Helper function
    private func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
}
