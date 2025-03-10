//
//  ConfirmExit.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 16/02/25.
//

import SwiftUI

struct ConfirmExit: View {
    var onConfirm: (() -> Void)?
    var onCancel: (() -> Void)?
    var dismiss: DismissAction?
    var texts = ConfirmExitTexts.self
    
    private func onTapOk() {
        onConfirm?()
        dismiss?()
    }
    
    private func onTapCancel() {
        onCancel?()
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image("confirmation")
                .frame(height: 100)
            Text(texts.subtitle)
                .size14()
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Constants.colorTextLight)
                .multilineTextAlignment(.center)
            VStack(spacing: 16) {
                Text(texts.btnOk)
                    .size13()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Constants.colorRed)
                    .clipShape(RoundedRectangle(cornerRadius: 56))
                    .onTapGesture(perform: onTapOk)
                Text(texts.btnCancel)
                    .size13()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(Constants.colorRed)
                    .clipShape(RoundedRectangle(cornerRadius: 56))
                    .overlay(RoundedRectangle(cornerRadius: 56).stroke(Constants.colorRed))
                    .onTapGesture(perform: onTapCancel)
            }
        }
        .padding()
    }
}

struct ConfirmExitTexts {
    static let subtitle = "Dengan menutup halaman ini, kamu akan keluar dari pantauan Tukang Bakso"
    static let btnOk = "OK"
    static let btnCancel = "Batal"
}
