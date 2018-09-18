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
//    let videos: [VideoModel] = {
//
//        let channel = ChannelModel(name: "Marcos", profileImageName: "marcos_user_profile")
//
//        let taylorVideo = VideoModel(title: "Taylor Swift - Bad Blood featuring Kendrick Lamar", thumbnail: "taylor_swift_vevo", numberOfViews: 1231312, uploadDate: nil, channel: channel)
//
//        let anittaVideo = VideoModel(title: "Anitta - Tudo Bem", thumbnail: "fica-tudo-bem-aniita", numberOfViews: 1231312, uploadDate: nil, channel: channel)
//
//        let maroon5Video = VideoModel(title: "Maroon 5 - Sugar", thumbnail: "sugar-maroon5", numberOfViews: 1231312, uploadDate: nil, channel: channel)
//
//        let brunoMarsVideo = VideoModel(title: "Bruno Mars - Uptown Fuck", thumbnail: "uptown-bruno-mars", numberOfViews: 1231312, uploadDate: nil, channel: channel)
//
//        return [taylorVideo, anittaVideo, maroon5Video, brunoMarsVideo]
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
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
        
        //Right Buttons
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    func fetchVideos() {
        print("Fetching ...")
        //let url = URL(string: "http://localhost:3000/youtube")
        
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [VideoModel]()
                for dict in json as! [[String: AnyObject]] {
                    
                    let title = dict["title"] as? String
                    let thumbnail = dict["thumbnail_image_name"] as? String
                    
                    let video = VideoModel(title: title!, thumbnail: thumbnail!, numberOfViews: 2, uploadDate: nil, channel: nil)
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
                
            } catch let jsonError {
                print(jsonError)
            }
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str)
        }.resume()
        
        
    }
    
    @objc func handleMore() {
        print("MORE MORE")
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
        view.addSubview(menuBarView)
        menuBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
        let sumAllSizeView:CGFloat = 16 + 88
        
        return CGSize(width: view.frame.width, height: height + sumAllSizeView)
    }
}

