//
//  ProductListViewController.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 16/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage


class ProductListViewController: UIViewController, ProductDelegate {
    @IBOutlet private weak var collectionView : UICollectionView!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    private var productListFromServer : [Product] = []
    
    
    
    override func viewDidLoad() {
        // Add activity indicator
        super.viewDidLoad()
        addActivityIndicator()
        
        // Set number of columns to collection view
        setCollectionViewColumns()
        
        // Check network connection before network call
        if Util.isConnectedToNetwork() {
            
            if let productList = DatabaseManager.getInstance.getProductList(){
                if productList.isEmpty {
                    makeAPICall()
                }else {
                    productListFromServer = productList
                    collectionView.reloadData()
                }
            }
        } else {
            if let productList = DatabaseManager.getInstance.getProductList(){
                if !productList.isEmpty {
                    productListFromServer = productList
                    collectionView.reloadData()
                }
            }
            showAlert("No Internet Connection", "Make sure your device is connected to the internet.")
        }
        
    }
    
    // This delegate method invoke after the completion of network call to get product list
    func onProductTaskComplete(_ productlist: [Product]?) {
        
       
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        if let productList = productlist {
            print("count\(productList.count)")
            self.productListFromServer = productList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
          
        }
    }
    
    
    private func makeAPICall(){
        activityIndicator.startAnimating()
        
        let productServiceProvider = ProductServiceProvider()
        productServiceProvider.getProductListFromServer(self)
    }
    
    private func setCollectionViewColumns(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        layout.itemSize = CGSize(width: (screenWidth/2) - 10, height: screenHeight/2.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        collectionView!.collectionViewLayout = layout
    }
    
    private func addActivityIndicator(){
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        activityIndicator.center = view.center;
        self.view.addSubview(activityIndicator)
    }
}




extension ProductListViewController :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewCellDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListFromServer.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 0
        
        let product = productListFromServer[indexPath.row]
        
        
        
        //cell.productIamge.image = UIImage(named: ("picture"))
        cell.productIamge.sd_setImage(with: URL(string: product.img!), placeholderImage: UIImage(named: "picture"))
        cell.labelProductName.text = product.name
        cell.labelProductPrice.text = "Price :\(product.price)"
        cell.labelVendorName.text = product.vendorname
        cell.labelVendorAddress.text = product.vendoraddress
        cell.buttonAddProduct.tag = indexPath.row
        cell.cellDelegate = self
        
        
        return cell
    }
    
    func didCellButtonTapped(_ cellPosition: Int) {
        let productFromCollection = productListFromServer[cellPosition]
        saveProduct(productFromCollection)
    }
    
    private func saveProduct(_ productFromCollection : Product){
        DatabaseManager.getInstance.saveCartProduct(productFromCollection)
        self.showAlert("Add To cart", productFromCollection.name! + " saved successfully!")
    }
    
    
}
