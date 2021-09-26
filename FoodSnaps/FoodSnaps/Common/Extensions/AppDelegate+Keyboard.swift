//
//  AppDelegate+Keyboard.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 26/09/2021.
//

import IQKeyboardManagerSwift

extension AppDelegate {
    func IQKeyboardSetup() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
