//
//  RegisterHeading.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 16/02/25.
//

import SwiftUI

struct RegisterHeading: View {
    var texts = RegisterHeadingTexts.self
    var body: some View {
        VStack {
            Image("verification")
            Text(texts.title)
                .size24()
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(texts.subtitle)
                .size12()
        }
        .padding()
    }
}

struct RegisterHeadingTexts {
    static let title = "Verifikasi"
    static let subtitle = "Masukkan nama dan role Anda di bawah ini:"
}
