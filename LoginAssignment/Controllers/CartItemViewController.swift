//
//  CartItemViewController.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 16/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit

class CartItemViewController: UIViewController {
     @IBOutlet private weak var tableView : UITableView!
    
    private var cartProductList : [Dictionary<String,Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabContainer = self.tabBarController as! TabBarController
        self.cartProductList = tabContainer.cartProductList
        tableView.reloadData()
    }

}

extension CartItemViewController : UITableViewDelegate,UITableViewDataSource,CartTableViewCellDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProductList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartRow", for: indexPath) as! CartTableViewCell
        let product = cartProductList[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
    
        cell.clipsToBounds = true
        if let productName = product["ProductName"] as? String {
            cell.labelProductName.text = productName
        }
        
        if let productPrice = product["ProductPrice"] as? String {
            cell.labelProductPrice.text = "Price : "+productPrice
        }
        
        if let vendorName = product["VendorName"] as? String {
            cell.labelVendorName.text = vendorName
        }
    
        
        cell.tableRowDelegate = self
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func didCellButtonTapped(_ cell: UITableViewCell) {
        let item = tableView.indexPath(for: cell)
        let position = item?.row
        let tabContainer = self.tabBarController as! TabBarController
        tabContainer.cartProductList.remove(at: position!)
        cartProductList.remove(at: position!)
        tableView.reloadData()
    }
    
}
