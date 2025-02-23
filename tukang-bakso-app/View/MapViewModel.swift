//
//  MapViewModel.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI
import FirebaseFirestore
import MapKit

class MapViewModel: ObservableObject {
    private var db: Firestore? = nil
    private var dbCollection: CollectionReference? = nil
    private var listener: ListenerRegistration? = nil
    private var documentId: String = ""
    private var locationManager = LocationManager()
    private var lastLocationUpdate = Date()
    private var hasLoaded = false
    
    private static let initialLocation = CLLocationCoordinate2D(latitude: -6.2291968, longitude: 106.807296)

    @Published var confirmExit = false
    @Published var lastLocation: CLLocation?
    @Published var userLocations: [UserLocation] = []
    @Published var region: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: MapViewModel.initialLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    init() {
        locationManager.$lastLocation.assign(to: &$lastLocation)
    }

    func onConfirmExit() {
        confirmExit = false
        locationManager.stopUpdatingLocation()
        deinitSocket()
    }
    
    func onCloseConfirmExit() {
        confirmExit = false
    }
    
    func setCurrentUserLocation(_ user: User) {
        let location = locationManager.lastLocation?.coordinate ?? MapViewModel.initialLocation
        userLocations.append(UserLocation(user: user, location: location, color: Constants.colorBlue))
        setRegion(location)
    }
    
    func initSocket() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        documentId = getDeviceID()
        db = Firestore.firestore()
        dbCollection = db?.collection(Config.firestoreCollection)
        modifyDocument()
        initDocument()
        listenDocument()
    }
    
    func deinitSocket() {
        removeDocument()
        listener?.remove()
        db = nil
        dbCollection = nil
        documentId = ""
    }
    
    func onChangeLocation(_ newCoordinate: CLLocationCoordinate2D) {
        guard Date().timeIntervalSince(lastLocationUpdate) >= 3 || !hasLoaded else { return }
        userLocations[0].location = newCoordinate
        setRegion(newCoordinate)
        modifyDocument()
        hasLoaded = true
    }
    
    private func setRegion(_ center: CLLocationCoordinate2D?) {
        region = .region(
            MKCoordinateRegion(
                center: center ?? MapViewModel.initialLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        )
    }
    
    private func getDeviceID() -> String {
        let key = Config.userDefaultDeviceId
        if let existingID = UserDefaults.standard.string(forKey: key) {
            return existingID
        } else {
            let newID = UUID().uuidString
            UserDefaults.standard.set(newID, forKey: key)
            return newID
        }
    }

    private func parseDocumentData(_ document: QueryDocumentSnapshot) -> UserLocation {
        let data = document.data()
        let user = User(
            name: data["user.name"] as? String ?? "",
            role: UserRole(rawValue: data["user.role"] as? String ?? "Tukang Bakso") ?? .TukangBakso
        )
        let location = CLLocationCoordinate2D(
            latitude: (data["coordinate"] as? GeoPoint)?.latitude ?? 0,
            longitude: (data["coordinate"] as? GeoPoint)?.longitude ?? 0
        )
        let color = user.role == .Customer ? Constants.colorGreen : Constants.colorOrange
        let userLocation = UserLocation(user: user, location: location, color: color)
        userLocation.documentID = document.documentID
        return userLocation
    }
    
    private func initDocument() {
        guard let dbCollection = dbCollection else { return }
        dbCollection.getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot else { return }
            snapshot.documents.forEach { item in
                let isExist = self.userLocations.contains { itemLocation in item.documentID == itemLocation.documentID }
                guard item.documentID != self.documentId, !isExist else { return }
                self.userLocations.append(self.parseDocumentData(item))
            }
        }
    }

    private func listenDocument() {
        guard let dbCollection = dbCollection else { return }
        listener = dbCollection.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot, let changes = snapshot.documentChanges.last else { return }
            if changes.type == .added {
                guard changes.document.documentID != self.documentId else { return }
                self.userLocations.append(self.parseDocumentData(changes.document))
            } else if changes.type == .removed {
                self.userLocations.removeAll { item in item.documentID == changes.document.documentID }
            } else if changes.type == .modified {
                let index = self.userLocations.firstIndex { item in item.documentID == changes.document.documentID }
                guard let index = index else { return }
                self.userLocations[index] = self.parseDocumentData(changes.document)
            }
        }
    }
    
    private func removeDocument() {
        guard let dbCollection = dbCollection else { return }
        dbCollection.document(documentId).delete()
    }
    
    private func modifyDocument() {
        guard let dbCollection = dbCollection, !documentId.isEmpty, let userLocation = userLocations.first else { return }
        dbCollection.document(documentId).setData([
            "coordinate": GeoPoint(
                latitude: userLocation.location.latitude,
                longitude: userLocation.location.longitude),
            "user.name": userLocation.name,
            "user.role": userLocation.role.rawValue,
        ], merge: true)
        lastLocationUpdate = Date()
    }
}
