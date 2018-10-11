//
//  FeedCell.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 03/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let feedCellId = "feedCellId"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.register(HomeCellView.self, forCellWithReuseIdentifier: feedCellId)
        return cv
    }()
    
    var videos: [VideoModel]?
    

    override func setupViews() {
        super.setupViews()
        addSubview(collectionView)
        setupConstraints()
        fetchVideos()
    }
    
    fileprivate func setupConstraints() {        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])
        
    }
    
    func fetchVideos() {
        ServiceAPI.shared.fetchingVideos { videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath) as! HomeCellView
        cell.video = videos?[indexPath.row]
        cell.backgroundColor = .white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let perfectRatio: CGFloat = 9 / 16
        let height: CGFloat = (frame.width - 16 - 16) * perfectRatio
        let sumAllSizeView:CGFloat = 16 + 88 + 10

        return CGSize(width: frame.width, height: height + sumAllSizeView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
}
