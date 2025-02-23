//
//  RegisterViewModel.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var user: User = {
        User(name: "", role: .TukangBakso)
    }()
    @Published var isAgree: Bool = false
}
