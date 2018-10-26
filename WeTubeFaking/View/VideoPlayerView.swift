//
//  VideoPlayerView.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 26/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerView: UIView, AVPlayerViewControllerDelegate {
    
    
    //    let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/default-7526d.appspot.com/o/Batman%20vs%20Superman.mp4?alt=media&token=f9aaf11d-8138-4333-b4c6-6f93fa3c2172"
    
    let observerPlayer = "currentItem.loadedTimeRanges"
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "pauseVideo")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    let indicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    
    let lengthTimeVideoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let startTimeVideoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    let timeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleTimeSlider), for: .valueChanged)
        return slider
    }()
    
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setupGradiantColor()
        setupVideoPlay()
        contentView.frame = frame
        addSubview(contentView)
        
        contentView.addSubview(self.indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        contentView.addSubview(self.playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(self.lengthTimeVideoLabel)
        self.lengthTimeVideoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        self.lengthTimeVideoLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.lengthTimeVideoLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.lengthTimeVideoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        
        contentView.addSubview(self.startTimeVideoLabel)
        self.startTimeVideoLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.startTimeVideoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        self.startTimeVideoLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.startTimeVideoLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        contentView.addSubview(self.timeSlider)
        self.timeSlider.trailingAnchor.constraint(equalTo: self.lengthTimeVideoLabel.leadingAnchor, constant: -4).isActive = true
        self.timeSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.timeSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.timeSlider.leadingAnchor.constraint(equalTo: startTimeVideoLabel.trailingAnchor, constant: 4).isActive = true
        
        
        backgroundColor = .black
        
    }
    
    var isPlaying = false
    var player: AVPlayer?
    func setupVideoPlay() {
        guard let url = URL(string: urlString) else { return }
        player = AVPlayer(url: url)
        let layer = AVPlayerLayer(player: player)
        self.layer.addSublayer(layer)
        layer.frame = self.frame
        player?.play()
        player?.addObserver(self, forKeyPath: self.observerPlayer, options: .new, context: nil)
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { (progressTime) in
            
            //Change Label of Start
            let seconds = CMTimeGetSeconds(progressTime)
            let secondString = String(format: "%02d", (Int(seconds) % 60))
            let minuteString = String(format: "%02d", Int(seconds / 60))
            self.startTimeVideoLabel.text = "\(minuteString):\(secondString)"
            
            //Change Thumbs of Slider
            guard let durations = self.player?.currentItem?.duration else { return }
            let durationSeconds = CMTimeGetSeconds(durations)
            self.timeSlider.value = Float(seconds / durationSeconds)
        })
        
        
    }
    
    func setupGradiantColor() {
        let gradiant = CAGradientLayer()
        gradiant.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiant.locations = [0.7, 1.2]
        self.contentView.layer.addSublayer(gradiant)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == self.observerPlayer {
            //            print(player?.status ?? "aahh =(")
            
            if !self.isPlaying {
                self.indicator.stopAnimating()
                self.contentView.backgroundColor = .clear
                self.isPlaying = true
                self.playPauseButton.isHidden = false
                
                if let duration = player?.currentItem?.duration {
                    let seconds = CMTimeGetSeconds(duration)
                    
                    let secondsText = Int(seconds) % 60
                    let minutesText = String(format: "%02d", Int(seconds) / 60)
                    lengthTimeVideoLabel.text = "\(minutesText):\(secondsText)"
                }
            }
        }
    }
    
    @objc func handlePlayPause() {
        
        if isPlaying {
            self.playPauseButton.setImage(UIImage(named: "playVideo"), for: .normal)
            self.player?.pause()
        } else {
            self.playPauseButton.setImage(UIImage(named: "pauseVideo"), for: .normal)
            self.player?.play()
        }
        self.isPlaying = !self.isPlaying
    }
    
    @objc func handleTimeSlider() {
        print(timeSlider.value)
        guard let duration = player?.currentItem?.duration else { return }
        
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(timeSlider.value) * totalSeconds
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            //perhaps do something later here
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
