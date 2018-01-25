//
//  TextField.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 23/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
import UIKit
class TextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    func  setPadding(_ paddingValue: CGFloat) {
        padding = UIEdgeInsets(top: 0, left: paddingValue, bottom: 0, right: paddingValue)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
