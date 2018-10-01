//
//  SettingLauncherModel.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 29/09/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import Foundation

struct SettingLauncherModel {
    let name: SettingLauncherName
    let imageName: String 
}

enum SettingLauncherName: String, CaseIterable {
    case settings = "Settings"
    case politcs = "Politicas de Privacidade"
    case feedbacks = "Enviar Feedbacks"
    case switchAccount = "Mudar de Conta"
    case cancel = "Cancelar"
}
