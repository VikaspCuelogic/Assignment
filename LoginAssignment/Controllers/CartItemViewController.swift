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
    
    @IBOutlet weak var lablelNoProducts: UILabel!
    private var cartList = [CartProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCartProductsFromCoreData()
    }
    
    private func getCartProductsFromCoreData(){
        
        if let cartList = DatabaseManager.getInstance.getCartProducts() {
            lablelNoProducts.isHidden = true
            tableView.isHidden = false
            self.cartList = cartList
            tableView.reloadData()
        }else{
            lablelNoProducts.isHidden = false
            tableView.isHidden = true
        }
    }
    
}

extension CartItemViewController : UITableViewDelegate,UITableViewDataSource,CartTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartRow", for: indexPath) as! CartTableViewCell
        let product = cartList[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        cell.labelProductName.text = product.productname
        cell.labelProductPrice.text = "Price : \(product.price)"
        cell.labelVendorName.text = product.vendorname
        cell.btnRemove.tag = indexPath.row
        cell.labelQuantity.text = "Quantity : \(product.qty)"
        cell.tableRowDelegate = self
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func didCellButtonTapped(_ cellPosition: Int) {
        
        if cellPosition < cartList.count {
            let deletedProductName = cartList[cellPosition].productname!
            DatabaseManager.getInstance.deleteEntity(cartList[cellPosition])
            DatabaseManager.getInstance.saveContext()
           
            
            cartList.remove(at: cellPosition)
            self.showAlert("Success!", deletedProductName + " Removed from cart")
            tableView.reloadData()
            if cartList.isEmpty {
                lablelNoProducts.isHidden = false
                tableView.isHidden = true
            }else {
                lablelNoProducts.isHidden = true
                tableView.isHidden = false
            }
           
        }
    }
    
}
