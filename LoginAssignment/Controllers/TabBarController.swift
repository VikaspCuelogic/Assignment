//
//  CartViewController.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 16/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    var reachability: Reachability? = Reachability.networkReachabilityForInternetConnection()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        
        _ = reachability?.startNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkReachability()
    }
    
    func checkReachability() {
        guard let r = reachability else { return }
        if r.isReachable  {
            view.backgroundColor = UIColor.green
        } else {
            showAlert("Network Error!","Make sure your device is connected to the internet.")
            view.backgroundColor = UIColor.red
        }
    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//        reachability?.stopNotifier()
//    }
//    
    @objc func reachabilityDidChange(_ notification: Notification) {
        checkReachability()
    }
}
