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
    
    func loadImage(urlString: String) {
        urlExist = urlString
        let url = URL(string: urlString)
        self.image = nil
        
        if let imageForCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageForCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            DispatchQueue.main.async {
                let imageForCache = UIImage(data: data!)
                if self.urlExist == urlString {
                    self.image = imageForCache
                }
                imageCache.setObject(imageForCache!, forKey: urlString as AnyObject)
            }
            }.resume()
    }
    
}
