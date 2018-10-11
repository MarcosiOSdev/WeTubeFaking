//
//  VideoModel.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 04/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import Foundation

struct VideoModel: Codable {
    
    let title: String
    let thumbnail: String
    let numberOfViews: NSNumber?
    let uploadDate: Date?
    let duration: Int
    let channel: ChannelModel?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: KeyCodings.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.thumbnail = try values.decode(String.self, forKey: .thumbnail)
        self.duration = try values.decode(Int.self, forKey: .duration)
        
        let numberOfViewsInt = try values.decode(Int.self, forKey: .numberOfViews)
        self.numberOfViews = NSNumber(value: numberOfViewsInt)
        self.channel = try values.decode(ChannelModel.self, forKey: .channel)
        self.uploadDate = Date()
    }
    
    func encode(to encoder: Encoder) throws {
        //
    }
    
    enum KeyCodings: String, CodingKey {
        case thumbnail = "thumbnail_image_name"
        case numberOfViews = "number_of_views"
        case title, duration, channel
    }
}
