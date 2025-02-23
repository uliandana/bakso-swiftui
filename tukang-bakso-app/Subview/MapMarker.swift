//
//  MapMarker.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 23/02/25.
//

import SwiftUI

struct MapMarker: View {
    var userLocation: UserLocation
    var body: some View {
        HStack(alignment: .center) {
            Image(userLocation.role == .Customer ? "ico_profile" : "ico_cart")
                .frame(width: 40, height: 40)
                .background(userLocation.color)
                .clipShape(Circle())
                .shadow(
                    color: Constants.colorShadow,
                    radius: 4, x: 0, y: 4
                )
            Text(userLocation.name)
                .size10()
                .frame(maxWidth: 120)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .offset(x: -20)
    }
}
