//
//  UIApplication+Customs.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 01/10/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
