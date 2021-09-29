//
//  AppDelegate.swift
//  FoodSnaps
//
//  Created by Malsha Hansini on 25/09/2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardSetup()
        FirebaseApp.configure()
        return true
    }
}

