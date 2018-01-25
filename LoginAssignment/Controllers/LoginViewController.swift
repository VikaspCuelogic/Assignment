//
//  ViewController.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 16/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    private let storedUserName = "Vikyshrau26@gmail.com"
    private let storedPassword = "Test1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFieldUserName.text = storedUserName
        textFieldPassword.text = storedPassword
    }
    
    @IBAction func validateCredentials(){
        
        guard let username = textFieldUserName.text else {
            return
        }
        
        guard let password = textFieldPassword.text else {
            return
        }
        
        if username.isEmpty{
            
            self.showAlert("Error","Username cannot be empty")
        } else if password.isEmpty {
            self.showAlert("Error","Password cannot be empty")
        } else if !isValidEmail(username){
            self.showAlert("Error","Invalid email")
        } else if !isValidPassword(password){
            self.showAlert("Error","password is too short")
        } else if !(username == storedUserName && password == storedPassword){
            self.showAlert("Error","Invalid username or password")
        } else {
            redirectToCartScreen()
        }
        
    }
    
    
    private func isValidEmail(_ email : String) -> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password : String) -> Bool {
        return password.count >= 8 ? true : false
    }
    
    private func redirectToCartScreen(){
        let cartViewController = storyboard?.instantiateViewController(withIdentifier: "TabViewController") as! TabBarController
        
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
}

