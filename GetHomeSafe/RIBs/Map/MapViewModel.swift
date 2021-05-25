//
//  MapViewModel.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/13.
//

import Foundation
import Combine
import NMapsMap

protocol MapPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func cameraLocationChanged()
}

extension MapViewController {
    final class ViewModel: MapPresentable {
        weak var listener: MapPresentableListener?
        weak var view: MapViewController?
        
        @Published var cctvMarkers: Set<NMFMarker> = Set()
        @Published var showCCTVs = false
        @Published var policeStationMarkers: Set<NMFMarker> = Set()
        @Published var showPoliceStations = false
        
        init() {
            setupBindings()
        }
        
        // MARK: - MapPresentable
        func showCCTVMarkers() {
            showCCTVs = true
        }
        
        func dismissCCTVMarkers() {
            showCCTVs = false
        }
        
        func showPoliceStationMarkers() {
            showPoliceStations = true
        }
        
        func dismissPoliceStationMarkers() {
            showPoliceStations = false
        }
        
        func showHotPlaceMarkers() {
            // TODO:
        }
        
        func dismissHotPlaceMarkers() {
            // TODO:
        }
        
        var currentCameraLocation: Location? {
            guard let cameraLocation = view?.naverMapView.mapView.cameraPosition.target else { return nil }
            return Location(latitude: cameraLocation.lat, longitude: cameraLocation.lng)
        }
        
        var currentLocation: CLLocation? { locationManager.location }
        
        func placeCCTVMarkers(with cctvs: [CCTV]) {
            cctvMarkers.forEach { $0.mapView = nil }
            cctvMarkers.removeAll()
            cctvs.forEach { cctv in
                let marker = NMFMarker(position: cctv.coordinate.toLatLong)
                marker.iconImage = .init(image: UIImage(systemName: "camera.aperture")!)
                marker.mapView = showCCTVs ? view?.naverMapView.mapView : nil
                cctvMarkers.insert(marker)
            }
        }
        
        func placePoliceStationMarkers(with policeStations: [PoliceStation]) {
            policeStationMarkers.forEach { $0.mapView = nil }
            policeStationMarkers.removeAll()
            policeStations.forEach { policeStation in
                let marker = NMFMarker(position: policeStation.coordinate.toLatLong)
                marker.iconImage = .init(image: UIImage(systemName: "building.2.crop.circle.fill")!)
                marker.mapView = showPoliceStations ? view?.naverMapView.mapView : nil
                policeStationMarkers.insert(marker)
            }
        }
        
        func cameraLocationChanged() {
            listener?.cameraLocationChanged()
        }
        
        func setupMap() {
            locationManager.requestWhenInUseAuthorization()
            // add camera delegate
            if let view = view { view.naverMapView.mapView.addCameraDelegate(delegate: view) }
        }
        
        // MARK: - Private
        private let locationManager = CLLocationManager()
        private var cancelBag = Set<AnyCancellable>()
        
        private func setupBindings() {
            $showCCTVs.sink { [weak self] isCCTVShowing in
                if isCCTVShowing {
                    self?.cctvMarkers.forEach { $0.mapView = self?.view?.naverMapView.mapView }
                } else {
                    self?.cctvMarkers.forEach { $0.mapView = nil }
                }
            }.store(in: &cancelBag)
            $showPoliceStations.sink { [weak self] isPoliceStationShowing in
                if isPoliceStationShowing {
                    self?.policeStationMarkers.forEach { $0.mapView = self?.view?.naverMapView.mapView }
                } else {
                    self?.policeStationMarkers.forEach { $0.mapView = nil }
                }
            }.store(in: &cancelBag)
        }
    }
}

extension Coordinate2D {
    var toLatLong: NMGLatLng {
        return NMGLatLng(lat: self.latitude, lng: self.longitude)
    }
}

#if DEBUG
extension Set where Element == NMFMarker {
//   / static let stub: Set<NMFMarker> = Set(arrayLiteral: NMFMarker(position: .init(lat: 10, lng: 10)))
}
#endif
