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
    private var cartProductList : [Dictionary<String,Any>] = []
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var cartList = [CartProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       getCartProducts()
    }
    
    private func getCartProducts(){
        do {
            cartList = try context.fetch(CartProduct.fetchRequest())
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if cartList.isEmpty {
            
            
            lablelNoProducts.isHidden = false
            tableView.isHidden = true
        }else{
            lablelNoProducts.isHidden = true
            tableView.isHidden = false
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
        cell.position = indexPath.row
        
        cell.tableRowDelegate = self
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func didCellButtonTapped(_ cellPosition: Int) {
        
        if cellPosition < cartList.count {
            context.delete(cartList[cellPosition])
            appDelegate.saveContext()
            cartList.remove(at: cellPosition)
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
