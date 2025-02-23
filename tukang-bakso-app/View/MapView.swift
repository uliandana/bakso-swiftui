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
    
    private var userLocationAnnotations: some MapContent {
        ForEach(viewModel.userLocations) { item in
            Annotation("", coordinate: item.location, anchor: .leading) {
                MapMarker(userLocation: item)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.region) {
                userLocationAnnotations
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
