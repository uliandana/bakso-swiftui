//
//  RegisterForm.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 16/02/25.
//

import SwiftUI

struct RegisterForm: View {
    @Binding var user: User
    @Binding var isAgree: Bool
    let texts = RegisterFormTexts.self

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text(texts.input_name).size14()
                TextInput(placeholder: texts.input_name, textValue: $user.name)
            }
            Spacer().frame(height: 2)
            HStack(alignment: .center, spacing: 8) {
                Text(texts.input_role).size14()
                Spacer()
                Picker("", selection: $user.role) {
                    ForEach(UserRole.allCases) { item in
                        Text(item.rawValue)
                    }
                }
            }
            Spacer().frame(height: 4)
            NavigationLink {
                MapView(user: $user.wrappedValue)
            } label: {
                Text(texts.cta)
                    .size13()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Constants.colorRed)
                    .clipShape(RoundedRectangle(cornerRadius: 56))
                    .opacity($user.wrappedValue.name.isEmpty || !$isAgree.wrappedValue ? 0.5 : 1)
            }
            .disabled($user.wrappedValue.name.isEmpty || !$isAgree.wrappedValue)
            Spacer().frame(height: 4)
            Toggle(isOn: $isAgree) {
                Text(texts.tnc)
                    .size10()
                    .lineSpacing(4)
            }
        }
        .padding()
        .background(Constants.colorFormBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white))
    }
}

struct RegisterFormTexts {
    static let input_name = "Nama"
    static let input_role = "Role"
    static let cta = "Join"
    static let tnc = "Dengan menggunakan aplikasi ini Anda telah setuju untuk membagikan lokasi Anda kepada para tukang Bakso Keliling."
}
