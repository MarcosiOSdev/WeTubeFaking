//
//  SettingLauncherCell.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 29/09/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit


class SettingLauncherCell: BaseCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "settings"))
        imageView.contentMode = .scaleAspectFill
        imageView.image?.withRenderingMode(.alwaysTemplate) //Pintar o conteudo da imagem
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var settingLauncher: SettingLauncherModel? {
        didSet {
            self.nameLabel.text = settingLauncher?.name.rawValue
            if let imageName = settingLauncher?.imageName {
                self.iconImageView.image = UIImage(named: imageName)
            }
            
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            if isHighlighted {
                backgroundColor = .darkGray
                iconImageView.tintColor = .white
                nameLabel.textColor = .white
            } else {
                backgroundColor = .white
                iconImageView.tintColor = .darkGray
                nameLabel.textColor = .black
            }
        }
    }
    
    override func setupViews() {
        super.setupViews()
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.spacing = 5
        addSubview(stackView)
        
        let contraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(contraints)     
    }
}
