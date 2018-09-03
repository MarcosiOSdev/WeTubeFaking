//
//  BaseCell.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 02/09/2018.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
