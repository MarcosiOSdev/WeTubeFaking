//
//  ViewController.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 31/08/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let cellId = "homeCellView"
    let trendingCellId = "trendingCellId"
    let subscribleCellId = "subscribleCellId"
    let titles = ["Home", "Mais vistos", "Subscritos", "Perfil"]
    
    
    lazy var settingLauncherView: SettingLauncherView = {
        let view = SettingLauncherView()
        view.delegate = self
        return view
    }()
    
    lazy var menuBarView: MenuBarView = {
        let mb = MenuBarView()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.delegate = self
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupMenuBar()
        setupCollectionView()
    }
    
    
    fileprivate func setupNavigation() {
        
        navigationController?.navigationBar.isTranslucent = false
        setTitle(index: 0)
        
        //Right Buttons
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    fileprivate func setupCollectionView() {
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        
        //top down because of menubar... top start at 50
        collectionView?.contentInset = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView.register(SubscribleCell.self, forCellWithReuseIdentifier: subscribleCellId)
    }
    
    fileprivate func setupMenuBar() {
        setupMenuBarBrain()
//        self.navigationController?.hidesBarsOnSwipe = true
//
//        view.addSubview(menuBarView)
//        if #available(iOS 11, *) {
//            menuBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        } else {
//            menuBarView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
//        }
////        menuBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        menuBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        menuBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupMenuBarBrain() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBarView)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBarView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBarView)
        
        menuBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setTitle(index: Int) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "     \(self.titles[index])"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    @objc func handleMore() {
        self.settingLauncherView.showSettings()
    }
    
    @objc func handleSearch() {
        self.settingLauncherView.showSettings()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indentifierCell: String
        if indexPath.item == 1 {
            indentifierCell = trendingCellId
        } else if indexPath.item == 2 {
            indentifierCell = subscribleCellId
        } else {
            indentifierCell = cellId
        }        
        
        let cell: FeedCell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifierCell, for: indexPath) as! FeedCell
        cell.backgroundColor = .white
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuBarView.imageButtons.count
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        menuBarView.leadingConstraintSeparator?.constant = scrollView.contentOffset.x / CGFloat(menuBarView.imageButtons.count)
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        self.menuBarView.selectMenu(index)
        self.setTitle(index: index)
        //print(index)
    }
    
    

}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

extension HomeViewController: MenuBarDelegate {
    func selectedMenuRow(indexPath: IndexPath) {
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        self.setTitle(index: indexPath.item)
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

extension HomeViewController: FeedCellDelegate {
    
    func selectedRow(video: VideoModel) {
        let videoLauncherVC = VideoLauncherViewController()
        videoLauncherVC.view.frame = UIApplication.shared.keyWindow!.frame
        videoLauncherVC.modalPresentationStyle = .overFullScreen
        self.present(videoLauncherVC, animated: true, completion: nil)
    }
    
    
}
