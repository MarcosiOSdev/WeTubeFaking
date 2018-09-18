//
//  VideoModel.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 04/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import Foundation

struct VideoModel {
    var title: String
    var thumbnail: String
    var numberOfViews: NSNumber?
    var uploadDate: Date?

    var channel: ChannelModel?
}

