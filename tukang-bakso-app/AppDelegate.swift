//
//  AppDelegate.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 20/02/25.
//

import UIKit

import FirebaseCore
import FirebaseFirestore

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        return true
    }
    
}
