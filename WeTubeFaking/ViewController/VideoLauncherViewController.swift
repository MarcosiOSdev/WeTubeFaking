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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Aspect Radio HD = * 9 / 16
        let videoPlayerHeight = self.view.frame.width * 9 / 16
        mediaPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.height, height: videoPlayerHeight))
        
        self.view.addSubview(tallContainerView)
        self.view.addSubview(mediaPlayerView!)
        
        self.navigationController?.isNavigationBarHidden = true
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUp))

        swipeDown.direction = .down
        swipeUp.direction = .up
        mediaPlayerView!.addGestureRecognizer(swipeUp)
        mediaPlayerView!.addGestureRecognizer(swipeDown)

    }
    
    
    @objc func swipeDown() {
        self.minimizeMp(minimized: true, animated: true)
    }
    
    @objc func swipeUp() {
        self.minimizeMp(minimized: false, animated: true)
    }
    
    lazy var isMinimized: Bool = {
        return self.tallContainerView.frame.origin.y > 0
    }()
    
    func minimizeMp(minimized: Bool, animated:Bool) {
        var tallContainerFrame: CGRect
        var containerFrame: CGRect
        
        var tallContainerAlpha:CGFloat
        
        if (minimized) {
            let mpWidth:CGFloat = 160
            let mpHeight:CGFloat = 90
            
            let x = 320 - mpWidth
            let y = self.view.bounds.size.height - mpHeight
            
            tallContainerFrame = CGRect(x: x, y: y, width: 320, height: self.view.bounds.size.height)
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
