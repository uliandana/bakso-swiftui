//
//  Color.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        if hexSanitized.count == 6 {
            let red = Double((rgb >> 16) & 0xFF) / 255.0
            let green = Double((rgb >> 8) & 0xFF) / 255.0
            let blue = Double(rgb & 0xFF) / 255.0
            
            self.init(red: red, green: green, blue: blue, opacity: 1)
        } else {
            let red = Double((rgb >> 24) & 0xFF) / 255.0
            let green = Double((rgb >> 16) & 0xFF) / 255.0
            let blue = Double((rgb >> 8) & 0xFF) / 255.0
            let alpha = Double(rgb & 0xFF) / 255.0
            
            self.init(red: red, green: green, blue: blue, opacity: alpha)
        }
    }
}
