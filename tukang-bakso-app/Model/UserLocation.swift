//
//  UserLocation.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI
import MapKit

class UserLocation: User, Identifiable {
    var documentID: String?
    var location: CLLocationCoordinate2D
    var color: Color
    
    init(user: User, location: CLLocationCoordinate2D, color: Color) {
        self.location = location
        self.color = color
        super.init(name: user.name, role: user.role)
    }
}
