//
//  CustomImageView.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 25/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    
    var urlExist: String?
    
    let urlSession = URLSession.shared
    var operation: URLSessionDataTask?
    func stopLoad() {
        self.operation?.cancel()
    }
    
    func loadImage(urlString: String) {
        urlExist = urlString
        let url = URL(string: urlString)
        self.image = nil
        
        if let imageForCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageForCache
            return
        }
        
        self.operation = urlSession.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            DispatchQueue.main.async {
                if let dataResp = data, let imageForCache = UIImage(data: dataResp) {
                    if self.urlExist == urlString {
                        self.image = imageForCache
                    }
                    imageCache.setObject(imageForCache, forKey: urlString as AnyObject)
                }
                
                
            }
        }
        self.operation?.resume()
    }
    
}
