//
//  ChannelModel.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 04/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import Foundation

struct ChannelModel: Codable {
    var name: String?
    var profileImageName: String? //profile_image_name
    
    enum CodingKeys: String, CodingKey {
        case profileImageName = "profile_image_name"
        case name
    }
    
}
