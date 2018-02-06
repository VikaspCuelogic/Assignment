//
//  CellView.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 18/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit

protocol UICollectionViewCellDelegate {
    func didCellButtonTapped(_ cellPosition:Int)
}

class CollectionViewCell: UICollectionViewCell {
    var cellDelegate : UICollectionViewCellDelegate!
     @IBOutlet weak var labelProductName : UILabel!
     @IBOutlet weak var labelProductPrice : UILabel!
     @IBOutlet weak var labelVendorName : UILabel!
     @IBOutlet weak var labelVendorAddress : UILabel!
     @IBOutlet weak var buttonAddProduct : UIButton!
     @IBOutlet weak var productIamge : UIImageView!
    
   
    @IBAction func addToCartClicked(_ sender: UIButton) {
        cellDelegate?.didCellButtonTapped(sender.tag)
    }
    
   
    
}
