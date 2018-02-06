//
//  HttpRequest.swift
//  LoginAssignment
//
//  Created by Vikas Patil on 24/01/18.
//  Copyright © 2018 Vikas Patil. All rights reserved.
//

import Foundation
import Alamofire
class HttpRequest {
    
    static let getInstance = HttpRequest()
    
    private init(){
        
    }
    
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
    
    func makeGetAPICallWithAlamofire(_ url : String)  {
        Alamofire.request(url).responseData { (resData) -> Void in
            print(resData.result.value!)
            let strOutput = String(data : resData.result.value!, encoding : String.Encoding.utf8)
            print("Response from alamofire :"+strOutput!)
        }

     
        
        
    }
    
}
