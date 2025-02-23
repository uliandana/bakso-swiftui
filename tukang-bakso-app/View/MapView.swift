//
//  MapView.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 14/02/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    var user: User
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = MapViewModel()
    
    var userLocationMarkers: some MapContent {
        ForEach(viewModel.userLocations) { item in
            Annotation("", coordinate: item.location, anchor: .leading) {
                HStack(alignment: .center) {
                    Image(item.role == .Customer ? "ico_profile" : "ico_cart")
                        .frame(width: 40, height: 40)
                        .background(item.color)
                        .clipShape(Circle())
                        .shadow(
                            color: Constants.colorShadow,
                            radius: 4, x: 0, y: 4
                        )
                    Text(item.name)
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
    }
    var body: some View {
        ZStack {
            Map(position: $viewModel.region) {
                userLocationMarkers
            }.onChange(of: viewModel.lastLocation) { oldValue, newValue in
                guard let newCoordinate = newValue?.coordinate else { return }
                viewModel.onChangeLocation(newCoordinate)
            }
            if viewModel.confirmExit {
                Constants.colorOverlay
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.confirmExit)
            }
            ButtonExit()
                .onTapGesture {
                    viewModel.confirmExit = !viewModel.confirmExit
                }
                .sheet(isPresented: $viewModel.confirmExit) {
                    ConfirmExit(
                        onConfirm: viewModel.onConfirmExit,
                        onCancel: viewModel.onCloseConfirmExit,
                        dismiss: dismiss
                    )
                    .presentationDetents([.height(358)])
                    .presentationDragIndicator(.visible)
                }
        }
        .toolbar(.hidden)
        .onAppear {
            viewModel.setCurrentUserLocation(user)
            viewModel.initSocket()
        }
    }
}
