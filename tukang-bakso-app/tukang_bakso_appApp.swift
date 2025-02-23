//
//  tukang_bakso_appApp.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 13/02/25.
//

import SwiftUI

@main
struct tukang_bakso_appApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            RegisterView()
        }
    }
}
