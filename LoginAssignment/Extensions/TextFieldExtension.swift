//
//  TextField.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 23/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    
    func setLeftPaddingPoints(_ spaceValue:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spaceValue, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
