//
//  CartProduct+CoreDataProperties.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 22/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//
//

import Foundation
import CoreData


extension CartProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartProduct> {
        return NSFetchRequest<CartProduct>(entityName: "CartProduct")
    }

    @NSManaged public var id: Int16
    @NSManaged public var vendorname: String?
    @NSManaged public var productname: String?
    @NSManaged public var productimg: String?
    @NSManaged public var price: Double
    @NSManaged public var qty: Int16

}
