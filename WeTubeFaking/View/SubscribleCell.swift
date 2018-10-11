//
//  SubscribleCell.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 06/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class SubscribleCell: FeedCell {
    override func fetchVideos() {
        ServiceAPI.shared.subscribleFetchingVideos { videos  in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
