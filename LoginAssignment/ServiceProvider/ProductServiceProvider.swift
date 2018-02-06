//
//  ProductServiceProvider.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 24/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation

protocol ProductDelegate {
    func onProductTaskComplete(_ productlist: [Product]?)
}

class ProductServiceProvider {
    private let GET_PRODUCT_URL : String = "https://mobiletest-hackathon.herokuapp.com/getdata/";
    public var productDelegate : ProductDelegate!
    
    func getProductListFromServer(_ productDelegate : ProductDelegate)  {
        let  httpRequest = HttpRequest.getInstance
        self.productDelegate = productDelegate
        
        httpRequest.makeGetAPICall(GET_PRODUCT_URL) {data, response, error in
            if let data = data {
                self.parseResult(data)
                self.productDelegate.onProductTaskComplete(DatabaseManager.getInstance.getProductList())
            }
        }
        httpRequest.makeGetAPICallWithAlamofire(GET_PRODUCT_URL)
    }
    
    
    private func parseResult(_ response : Data){
        let decoder = JSONDecoder()
        
        do {
            let productListFromServer = try decoder.decode(ResponseModel.self, from: response)
            storeProductList(productListFromServer.products)
        } catch let decodeError as NSError {
            print("\(decodeError.localizedDescription)")
        }
        
    }
    
    private func storeProductList(_ productList : [ProductModel]){
        let context = DatabaseManager.getInstance.persistentContainer.viewContext
        
        for (index,product) in productList.enumerated(){
            let productToStore = Product(entity: Product.entity(), insertInto: context)
            
            productToStore.id = Int32(index)
            productToStore.name = product.productname
            productToStore.price = Double(product.price)!
            productToStore.img = product.productImg
            productToStore.vendorname = product.vendorname
            productToStore.vendoraddress = product.vendoraddress
            productToStore.phoneno = product.phoneNumber
            
            // Save data
            DatabaseManager.getInstance.saveContext()
            
            
        }
    }
    
    
}
