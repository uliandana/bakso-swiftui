//
//  ButtonExit.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI

struct ButtonExit: View {
    var body: some View {
        Image(systemName: "multiply")
            .foregroundColor(.black)
            .background(.white)
            .safeAreaPadding(8)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .position(x: 350, y: 10)
            .imageScale(.large)
            .shadow(
                color: Constants.colorShadow,
                radius: 4, x: 0, y: 4
            )
    }
}
