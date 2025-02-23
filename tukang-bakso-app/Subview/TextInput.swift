//
//  TextInput.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 14/02/25.
//

import SwiftUI

struct TextInput: View {
    var placeholder: String
    var textValue: Binding<String>

    var body: some View {
        TextField(placeholder, text: textValue)
            .textSize14()
            .padding(8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Constants.colorBorder))
            .autocorrectionDisabled()
    }
}
