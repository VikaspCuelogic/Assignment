//
//  HttpRequest.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 24/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation

class HttpRequest {
    private var serverData : Data?
    
    func makeGetAPICall(_ url : String,completionListener : @escaping (Data?,URLResponse?,Error?) -> Void)  {
    
        let session = URLSession.shared
        let url = URL(string: url)!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
            }else if let data = data,let response = response as? HTTPURLResponse,response.statusCode == 200 {
                //let responseData = String(data: data, encoding: String.Encoding.utf8)
                //print("Response data "+responseData!)
                completionListener(data,response,error)
            }
           
        }
        task.resume()
    
    }
    
}
