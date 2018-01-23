//
//  CartTableViewCell.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 18/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit
protocol CartTableViewCellDelegate {
    func didCellButtonTapped(_ cellPoisition:Int)
}
class CartTableViewCell: UITableViewCell {
    var tableRowDelegate : CartTableViewCellDelegate!
    @IBOutlet weak var btnCallVendor: UIButton!
    @IBOutlet weak var btnRemoveFromCart: UIButton!
    @IBOutlet weak var labelVendorAddress: UILabel!
    @IBOutlet weak var labelVendorName: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var position:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func onRemoveBtnClick(_ sender: Any) {
         tableRowDelegate.didCellButtonTapped(self.position)
    }
    
}
