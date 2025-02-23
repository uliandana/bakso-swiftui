//
//  ContentView.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 13/02/25.
//

import SwiftUI

// TODO
// Socket
// Lint
// Sonarqube
// Unit test

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                RegisterHeading()
                RegisterForm(
                    user: $viewModel.user,
                    isAgree: $viewModel.isAgree
                )
                Spacer()
            }
            .padding([.leading, .trailing], 24)
            .background(Constants.colorBackground)
        }
    }
}
