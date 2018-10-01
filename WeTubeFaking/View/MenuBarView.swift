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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var leadingConstraintSeparator: NSLayoutConstraint?
    let cellId = "MenuBarId"
    let imageButtons = ["home", "play", "albums", "account"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(separatorView)
        
        collectionView.register(MenuCellView.self, forCellWithReuseIdentifier: cellId)
        
        //Seleciona o primeiro tabbar
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Dont use Storyboard")
    }
    
    fileprivate func setupConstraints() {
        self.leadingConstraintSeparator = separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let constraints = [
            //Collections
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //Separators
            separatorView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4),
            separatorView.heightAnchor.constraint(equalToConstant: 6),
            self.leadingConstraintSeparator,
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints as! [NSLayoutConstraint])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * collectionView.frame.width / CGFloat(imageButtons.count)
        self.leadingConstraintSeparator?.constant = x
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageButtons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCellView
        cell.imageView.image = UIImage(named: imageButtons[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeButtons = CGFloat(imageButtons.count)
        return CGSize(width: frame.width / sizeButtons , height: frame.height)
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
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}









