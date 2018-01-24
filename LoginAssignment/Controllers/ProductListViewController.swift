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

   
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var productListFromServer : [ProductModel] = []
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    
    override func viewDidLoad() {
        
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.gray;
        activityIndicator.center = view.center;
        super.viewDidLoad()
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
    
        layout.itemSize = CGSize(width: (screenWidth/2) - 10, height: screenHeight/2.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
       
        collectionView!.collectionViewLayout = layout
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        // API Call
        self.makeAPICall()
       
     

    }
    

    
    
    private func makeAPICall(){
       
        
        let session = URLSession.shared
        let url = URL(string: "https://mobiletest-hackathon.herokuapp.com/getdata/")!
    
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async { // Correct
                self.activityIndicator.stopAnimating()
            }
           
            if let error = error {
               
              print(error)
            }else if let data = data,let response = response as? HTTPURLResponse,response.statusCode == 200 {
                self.parseResult(data)
                DispatchQueue.main.async { // Correct
                     self.activityIndicator.stopAnimating()
                     self.collectionView.reloadData()
                }
            }
        }
        
         task.resume()
    }
    
    private func parseResult(_ response : Data){
    
        let decoder = JSONDecoder()
       
        do {
            let productListFromServer = try decoder.decode(ResponseModel.self, from: response)
            storeProductList(productListFromServer.products)
            self.productListFromServer = productListFromServer.products
            print("count \(self.productListFromServer.count)")
        } catch let decodeError as NSError {
            print("\(decodeError.localizedDescription)")
        }
        
    }
    
    private func storeProductList(_ productList : [ProductModel]){
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
            appDelegate.saveContext()
            // add product to collection view list

            
        }
    }
    
}




extension ProductListViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewCellDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListFromServer.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
    
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 0
        
            let product = productListFromServer[indexPath.row]
   
            cell.productIamge.image = UIImage(named: ("picture"))
            cell.labelProductName.text = product.productname
            cell.labelProductPrice.text = "Price :"+product.price
            cell.labelVendorName.text = product.vendorname
            cell.labelVendorAddress.text = product.vendoraddress
            cell.position = indexPath.row
            cell.cellDelegate = self
    
    
        return cell
    }
    
    func didCellButtonTapped(_ cellPosition: Int) {
        
        let cartProduct = CartProduct(entity: CartProduct.entity(), insertInto: context)
        
        let productFromCollection = productListFromServer[cellPosition]
        
        cartProduct.id = Int16(cellPosition)
        cartProduct.productname = productFromCollection.productname
        cartProduct.price = Double(productFromCollection.price)!
        cartProduct.vendorname = productFromCollection.vendorname
        
        appDelegate.saveContext()
    }
    
}
