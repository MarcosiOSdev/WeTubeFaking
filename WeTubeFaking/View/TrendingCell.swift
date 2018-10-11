//
//  TrendingCell.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 06/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ServiceAPI.shared.trendingFetchingVideos { videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
