//
//  VideoLauncherViewController.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 12/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class VideoLauncherViewController: UIViewController {
    
    
    
    lazy var tallContainerView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    var mediaPlayerView : VideoPlayerView?
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarView?.isHidden = true
        self.view.backgroundColor = .clear
        self.view.isOpaque = false        
        
        setupMediaPlayer()
        self.view.addSubview(self.tallContainerView)
        self.view.addSubview(self.mediaPlayerView!)
    }
   
    
    func setupMediaPlayer() {
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        //Aspect Radio HD = * 9 / 16
        let videoPlayerHeight = keyWindow.frame.width * 9 / 16
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
        
        self.mediaPlayerView = VideoPlayerView(frame: videoPlayerFrame)
        self.mediaPlayerView?.delegate = self
        
        // Configure Gesture Recognizer
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUp))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeDown.direction = .down
        swipeUp.direction = .up
        swipeLeft.direction = .left
        self.mediaPlayerView!.addGestureRecognizer(swipeUp)
        self.mediaPlayerView!.addGestureRecognizer(swipeDown)
        self.mediaPlayerView!.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func swipeLeft() {
        if self.isMinimized! {
            guard let mediaPlayerView = self.mediaPlayerView else { return }
            
            mediaPlayerView.player?.pause()
            
            let width = UIScreen.main.bounds.width - UIScreen.main.bounds.width / 2
            let x = width - mediaPlayerView.frame.width
            let y = self.view.bounds.size.height - mediaPlayerView.frame.height
            let newFrame:CGRect = CGRect(x: x, y: y, width: mediaPlayerView.frame.width, height: mediaPlayerView.frame.height)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.mediaPlayerView?.frame = newFrame
            }) { _  in
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    
    @objc func swipeDown() {
        self.minimizeMp(minimized: true, animated: true)
    }
    
    @objc func swipeUp() {
        self.minimizeMp(minimized: false, animated: true)
    }
    
    var isMinimized: Bool?
    func minimizeMp(minimized: Bool, animated:Bool) {
        var tallContainerFrame: CGRect
        var containerFrame: CGRect
        
        var tallContainerAlpha:CGFloat
        self.isMinimized = minimized
        if (minimized) {
            let mpWidth:CGFloat = 200 // -20
            let mpHeight:CGFloat = 110 //-20
            
            let width = UIScreen.main.bounds.width
            let x = width - mpWidth
            let y = self.view.bounds.size.height - mpHeight
            
            tallContainerFrame = CGRect(x: x, y: y, width: 370, height: self.view.bounds.size.height)
            containerFrame = CGRect(x: x, y: y, width: mpWidth, height: mpHeight)
            tallContainerAlpha = 0.0
            
        } else {
            tallContainerFrame = self.view.frame;
            let videoPlayerHeight = self.view.frame.width * 9 / 16
            containerFrame = CGRect(x: 0, y: 0, width: self.view.frame.height, height: videoPlayerHeight)
            tallContainerAlpha = 1.0
        }
        
        let duration:TimeInterval = animated ? 0.5 : 0.0
        
        
        UIView.animate(withDuration: duration) {
            self.tallContainerView.frame = tallContainerFrame
            self.mediaPlayerView!.frame = containerFrame
            self.mediaPlayerView!.changeFramePlayer()
            self.tallContainerView.alpha = tallContainerAlpha
        }
        
    }
    
    func showVideoPlayer() {
        print("Showing your video player ...")
        guard let keyWindow = UIApplication.shared.keyWindow else {return}
        let contentView = UIView(frame: keyWindow.frame)
        contentView.backgroundColor = .white
        
        //Deixa pequeno la ponta direita para animacao
        contentView.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 20, height: 20)
        
        //Aspect Radio HD = * 9 / 16
        let videoPlayerHeight = keyWindow.frame.width * 9 / 16
        let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
        let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
        contentView.addSubview(videoPlayerView)
        keyWindow.addSubview(contentView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            contentView.frame = keyWindow.frame
        }) { completed in
            if completed {
                UIApplication.shared.statusBarView?.isHidden = true
            }
        }
    }
    
}

extension VideoLauncherViewController: VideoPlayerDelegate {
    func swipeDownTapped() {
        self.swipeDown()
    }
}
