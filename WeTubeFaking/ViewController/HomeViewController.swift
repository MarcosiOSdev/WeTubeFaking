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
    var videos: [VideoModel]?
    
    lazy var settingLauncherView: SettingLauncherView = {
        let view = SettingLauncherView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        setupNavigation()
        setupMenuBar()
        
        
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeCellView.self, forCellWithReuseIdentifier: cellId)
        
        //top down because of menubar... top start at 50
        collectionView?.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    //StatusBar com cor branca
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = titleInViewController
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = titleInViewController
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        //Right Buttons
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    func fetchVideos() {
        ServiceAPI.shared.fetchingVideos { videos in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    @objc func handleMore() {
        self.settingLauncherView.showSettings()
    }
    
    @objc func handleSearch() {
        print("HANDLE")
    }
    
    let menuBarView: MenuBarView = {
        let mb = MenuBarView()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    fileprivate func setupMenuBar() {
        
        
        self.navigationController?.hidesBarsOnSwipe = true
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = menuBarView.backgroundColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)        
        view.addSubview(menuBarView)
        
        
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        if #available(iOS 11, *) {
            menuBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            menuBarView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
        menuBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos != nil ? (videos?.count)! : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCellView
        cell.video = videos?[indexPath.row]
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
        let sumAllSizeView:CGFloat = 16 + 88 + 10
        
        return CGSize(width: view.frame.width, height: height + sumAllSizeView)
    }
}

extension HomeViewController: SettingLauncherDelegate {
    func selected(setting: SettingLauncherModel) {
        let dummyVC = UIViewController()
        self.navigationController?.pushViewController(dummyVC, animated: true)
        
        dummyVC.navigationItem.title = setting.name.rawValue
        dummyVC.navigationController?.navigationBar.tintColor = .white
        dummyVC.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white] 
        dummyVC.view.backgroundColor = .white
        
    }
    
    
}
