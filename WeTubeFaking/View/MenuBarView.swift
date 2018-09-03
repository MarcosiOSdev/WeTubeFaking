//
//  MenuBarView.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 02/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class MenuBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "MenuBarId"
    let imageButtons = ["home", "play", "albums", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.register(MenuCellView.self, forCellWithReuseIdentifier: cellId)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
//        let constraints = [
//            collectionView.topAnchor.constraint(equalTo: topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ]
//        NSLayoutConstraint.activate(constraints)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCellView
        
        cell.imageView.image = UIImage(named: imageButtons[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4 , height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


class MenuCellView: BaseCell {

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "home")
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
    
    func constraints() {
        addConstraintsWithFormat("H:|[v0(28)]|", views: imageView)
        addConstraintsWithFormat("V:|[v0(28)]|", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}









