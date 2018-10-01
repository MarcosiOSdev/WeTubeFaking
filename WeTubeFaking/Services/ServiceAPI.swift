//
//  ServiceAPI.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 30/09/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class ServiceAPI: NSObject {
    
    static let shared = ServiceAPI()
    private override init() {
        super.init()
    }
    
    func fetchingVideos(completed: @escaping (_ videos: [VideoModel]) -> Void ){
        
        let url = URL(string: "http://localhost:3000/youtube")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [VideoModel]()
                for dict in json as! [[String: AnyObject]] {
                    
                    let title = dict["title"] as? String
                    let thumbnail = dict["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dict["channel"] as! [String: AnyObject]
                    var channel = ChannelModel()
                    channel.name = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as?  String
                    let video = VideoModel(title: title!, thumbnail: thumbnail!, numberOfViews: 2, uploadDate: nil, channel: channel)
                    videos.append(video)
                }
                
                completed(videos)
                
            } catch let jsonError {
                print(jsonError)
            }
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str ?? "")
            }.resume()
        
    }

}
