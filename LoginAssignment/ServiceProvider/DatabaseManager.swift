//
//  DatabaseManager.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 25/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
import CoreData
class DatabaseManager {
    static let getInstance = DatabaseManager()
    
    private init(){
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductData")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved errror \(err), \(err.userInfo)")
            }
        }
    }
    
    func deleteEntity(_ entity : NSManagedObject){
        let context = persistentContainer.viewContext
        context.delete(entity)
    }

    func saveCartProduct(_ product : Product){
        let context = persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "CartProduct")
        let predicate = NSPredicate(format: "id = '\(String(describing: product.id))'")
        fetchRequest.predicate = predicate
        do
        {
            let cartProduct = try context.fetch(fetchRequest) as! [CartProduct]
            if cartProduct.count == 1{
                // Product already exist update qty value
                let cartProductToUpdate = cartProduct[0]
                var quantity : Int16 = cartProductToUpdate.qty
                quantity += 1
                cartProductToUpdate.setValue(quantity, forKey: "qty")
                
                do{
                    try context.save()
                }
                catch
                {
                    print(error)
                }
            }else{
                // Product does not exist in insert new product
                let cartProduct = CartProduct(entity: CartProduct.entity(), insertInto: context)
                
                cartProduct.id = Int16(product.id)
                cartProduct.productname = product.name
                cartProduct.price = Double(product.price)
                cartProduct.vendorname = product.vendorname
                cartProduct.qty = 1
                saveContext()
            }
        }
        catch
        {
            print(error)
        }
    }
    
    func getProductList() -> [Product]?{
        do {
            let context = persistentContainer.viewContext
            let productList = try context.fetch(Product.fetchRequest()) as! [Product]
            return productList
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
     func getCartProducts() -> [CartProduct]?{
        do {
            let context = persistentContainer.viewContext
            let cartProductList = try context.fetch(CartProduct.fetchRequest()) as! [CartProduct]
            return cartProductList
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
}
