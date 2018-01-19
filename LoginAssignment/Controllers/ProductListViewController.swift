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
                for product in productDictionaries {
                    products.append(product)
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
        
            cell.cellDelegate = self
        

    
        return cell
    }
    
    func didCellButtonTapped(_ cell: CollectionViewCell) {
        let item = collectionView.indexPath(for: cell)
        let position = item?.row
        let tabContainer = self.tabBarController as! TabBarController
        tabContainer.cartProductList.append(products[position!])
    
    }
    
}
