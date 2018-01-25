//
//  NetworkDelegate.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 25/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
protocol NetworkDelegate {
    func onTaskCompleted(_ data : Data)
}
