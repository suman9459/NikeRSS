//
//  NetWorkManager.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit
class NetWorkManager: NSObject {
    
    // NSURLSession
    let sharedURLSession = URLSession.shared
    
    static var sharedNetworkManager:NetWorkManager = {
        let networkManager = NetWorkManager()
        return networkManager
     }()
    
    class func shared()-> NetWorkManager {
        return sharedNetworkManager
    }

    // Pass base URL and get data
    func getData(url: String,completionHandler: @escaping (_ data: Data)->Void) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
        
            getRequest(request: request) { (data) in
                completionHandler(data)
            }
        }
    }
    
    // Service Call to get data from an API
     func getRequest(request: URLRequest, completionHandler: @escaping (_ data: Data)->Void) {
         let task = sharedURLSession.dataTask(with: request) { ( data, response, error) in
             guard let data = data,
                 let _ = response as? HTTPURLResponse,
                 error == nil else {
                     print("error", error ?? "Unknown error")
                     return
             }
             //let jsondata = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
             completionHandler(data)
         }
         task.resume()
     }
 
    
    
    // Get Image data
    func downloadImage(imageUrl: String,completionHandler: @escaping (UIImage)->Void){
        if let url = URL(string: imageUrl) {
            sharedURLSession.downloadTask(with: url) { (templocation, response, error) in
                if let location = templocation {
                    do {
                        let imdata = try Data(contentsOf: location)
                        if let image = UIImage(data: imdata){
                            completionHandler(image)
                        }
                    } catch let eror {
                        print(eror.localizedDescription)
                    }
                } else {
                    print(error.debugDescription)
                }
            }.resume()
        }
    }
    
}
