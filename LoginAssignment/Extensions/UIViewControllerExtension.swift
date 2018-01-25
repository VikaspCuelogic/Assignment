//
//  AlertControllerUtil.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 24/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    
    func showAlert(_ title :String,_ message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
