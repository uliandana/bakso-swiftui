//
//  User.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 16/02/25.
//

class User {
    var name: String
    var role: UserRole
    
    init(name: String, role: UserRole) {
        self.name = name
        self.role = role
    }
}

enum UserRole: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case TukangBakso = "Tukang Bakso"
    case Customer = "Customer"
}
