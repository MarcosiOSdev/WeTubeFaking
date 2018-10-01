//
//  SettingLauncherView.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 29/09/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

protocol SettingLauncherDelegate {
    func selected(setting: SettingLauncherModel)
}

class SettingLauncherView: NSObject {
    
    override init() {
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self        
        self.collectionView.register(SettingLauncherCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        return cv
    }()
    
    var delegate: SettingLauncherDelegate?
    
    lazy var settings:[SettingLauncherModel] = {
        var settings = [SettingLauncherModel]()
        settings.append(SettingLauncherModel(name: .settings, imageName: "settings"))
        settings.append(SettingLauncherModel(name: .politcs, imageName: "privacy"))
        settings.append(SettingLauncherModel(name: .feedbacks, imageName: "feedback"))
        settings.append(SettingLauncherModel(name: .switchAccount, imageName: "switch_account"))
        settings.append(SettingLauncherModel(name: .cancel, imageName: "cancel"))
        return settings
    }()
    
    let cellId = "settingLaucherCellID"
    let cellHeight: CGFloat = 50
    
    func showSettings() {
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        //Cria a tela preta atras para nao ser clicavel.
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            window.addSubview(collectionView)

            blackView.frame = window.frame
            
            //Start Variavel para a animacao
            blackView.alpha = 0
            let heigthCollectionView = CGFloat(settings.count) * cellHeight + 100
            let y = window.frame.height - heigthCollectionView
            
            hiddenPositionCollectionView()
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
                self.collectionView.frame =
                    CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: heigthCollectionView)
            }
        }
    }
    
    @objc func handleDismiss() {
        self.handleDismissSwift()
    }
    
    func handleDismissSwift(setting: SettingLauncherModel? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.hiddenPositionCollectionView()
        }) { completed in
            if completed {                
                guard let setting = setting else { return }
                if setting.name != .cancel {
                    self.delegate?.selected(setting: setting)
                }
            }
        }
    }

    fileprivate func hiddenPositionCollectionView() {
        let heigthCollectionView = CGFloat(settings.count) * cellHeight + 100
        if let window = UIApplication.shared.keyWindow {
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigthCollectionView)
        }
    }
}



extension SettingLauncherView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingLauncherCell
        cell.settingLauncher = self.settings[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.row]
        handleDismissSwift(setting: setting)
    }
}
