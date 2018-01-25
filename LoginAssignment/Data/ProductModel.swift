//
//  Product.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 23/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation

struct ProductModel : Decodable {
    let id : Int32?
    let productname : String
    let price : String
    let vendorname : String
    let vendoraddress : String
    let productImg :String
    let productGallery : [String]
    let phoneNumber  : String
}
