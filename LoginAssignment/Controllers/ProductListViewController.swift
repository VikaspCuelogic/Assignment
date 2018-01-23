//
//  ProductListViewController.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 16/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    @IBOutlet private weak var collectionView : UICollectionView!

    private var products: [Dictionary<String, Any>] = []
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
    
        layout.itemSize = CGSize(width: (screenWidth/2) - 10, height: screenHeight/2.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
       
        collectionView!.collectionViewLayout = layout
        

        readProductList()
    }

    private func readProductList(){
        
        if let path = Bundle.main.path(forResource: "Products", ofType: "plist") {
        
            //If your plist contain root as Array
            if let productDictionaries  = NSArray(contentsOfFile: path) as? [Dictionary<String, Any>] {
                for (index,productFromPlist) in productDictionaries.enumerated() {
                    
                   
                    let product = Product(entity: Product.entity(), insertInto: context)
                   
                    product.id = Int32(index)
                  
                    
                    if let productName = productFromPlist["ProductName"] as? String {
                         product.name = productName
                    }
                    
                    if let productPrice = productFromPlist["ProductPrice"] as? Double {
                        product.price = productPrice
                    }
                    
                    if let vendorName = productFromPlist["VendorName"] as? String {
                         product.vendorname = vendorName
                    }
                    
                    if let vendorAddress = productFromPlist["VendorAddress"] as? String {
                        product.vendoraddress = vendorAddress
                    }
                    // Save data
                    appDelegate.saveContext()
                    
                    products.append(productFromPlist)
                    
                   // let index = IndexPath(row:products.count - 1, section:0)
                    //collectionView?.insertItems(at: [index])
                
                }
                
                
                
            }
        }
    }
    
    
}

extension ProductListViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewCellDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
    
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 0
        
            let product = products[indexPath.row]
   
            cell.productIamge.image = UIImage(named: ("picture"))
        
            if let productName = product["ProductName"] as? String {
                cell.labelProductName.text = productName
            }
        
            if let productPrice = product["ProductPrice"] as? String {
                cell.labelProductPrice.text = "Price :"+productPrice
            }
        
            if let vendorName = product["VendorName"] as? String {
                cell.labelVendorName.text = vendorName
            }
        
            if let vendorAddress = product["VendorAddress"] as? String {
                cell.labelVendorAddress.text = vendorAddress
            }
            cell.position = indexPath.row
            cell.cellDelegate = self
    
    
        return cell
    }
    
    func didCellButtonTapped(_ cellPosition: Int) {
        
        let cartProduct = CartProduct(entity: CartProduct.entity(), insertInto: context)
        
        let productFromPlist = products[cellPosition]
        
        
        
        cartProduct.id = Int16(cellPosition)
        
        if let productName = productFromPlist["ProductName"] as? String {
            cartProduct.productname = productName
        }
        
        if let productPrice = productFromPlist["ProductPrice"] as? Double {
            cartProduct.price = productPrice
        }
        
        if let vendorName = productFromPlist["VendorName"] as? String {
            cartProduct.vendorname = vendorName
        }
        
        appDelegate.saveContext()
    }
    
}
