//
//  ViewController.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 31/08/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let cellId = "HomeCellView"
    let titleInViewController = "MarcosTube"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupMenuBar()
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeCellView.self, forCellWithReuseIdentifier: cellId)
        
        //top down because of menubar... top start at 50
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = titleInViewController
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = titleInViewController
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    let menuBarView: MenuBarView = {
        let mb = MenuBarView()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    fileprivate func setupMenuBar() {
        view.addSubview(menuBarView)
        menuBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        //cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let perfectRatio: CGFloat = 9 / 16
        let height: CGFloat = (view.frame.width - 16 - 16) * perfectRatio
        let sumAllSizeView:CGFloat = 16 + 68
        
        return CGSize(width: view.frame.width, height: height + sumAllSizeView)
    }
}

