//
//  Product+CoreDataProperties.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 23/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int32
    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneno: String?
    @NSManaged public var price: Double
    @NSManaged public var vendoraddress: String?
    @NSManaged public var vendorname: String?

}
