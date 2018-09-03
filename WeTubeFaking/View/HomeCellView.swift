//
//  HomeCellView.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 31/08/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import Foundation
import UIKit

class HomeCellView: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "taylor_swift_vevo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "marcos_user_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)            
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift - Blank Space"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO - 1.604.684.000 visualizações - 2 anos atras"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    
    override func setupViews() {
        addSubview(separatorView)
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        setupConstraint()
        
//        let constraints = [
//            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8),
//            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//
//            userProfileImageView.widthAnchor.constraint(equalToConstant: 44),
//            userProfileImageView.heightAnchor.constraint(equalToConstant: 44),
//            userProfileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            userProfileImageView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8),
//
//            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            separatorView.heightAnchor.constraint(equalToConstant: 1),
//            separatorView.topAnchor.constraint(equalTo: subtitleTextView.bottomAnchor),
//            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            titleLabel.heightAnchor.constraint(equalToConstant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
//            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
//
//            subtitleTextView.heightAnchor.constraint(equalToConstant: 30),
//            subtitleTextView.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor),
//            subtitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
//            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
//
//        ]
//        NSLayoutConstraint.activate(constraints)
    }
    
    func setupConstraint() {
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}
