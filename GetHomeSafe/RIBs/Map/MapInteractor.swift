//
//  MapInteractor.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs
import NMapsMap
import Combine

protocol MapRouting: ViewableRouting {
    func routeToFloatingActions()
}

protocol MapPresentable: Presentable {
    var listener: MapPresentableListener? { get set }
    func placeCCTVMarkers(with cctvs: [CCTV])
    var currentCameraLocation: Location? { get }
    
    func showCCTVMarkers()
    func dismissCCTVMarkers()
    func showPoliceStationMarkers()
    func dismissPoliceStationMarkers()
    func showHotPlaceMarkers()
    func dismissHotPlaceMarkers()
    
}

protocol MapListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MapInteractor: PresentableInteractor<MapPresentable>, MapInteractable, MapPresentableListener {
    func cameraLocationChanged() {
        guard let currentCameraLocation = presenter.currentCameraLocation else { return }
            cctvUseCase.getCCTVs(near: currentCameraLocation).sink { [weak self] cctvs in
                self?.presenter.placeCCTVMarkers(with: cctvs)
            }.store(in: &cancelBag)
    }
    
    weak var router: MapRouting?
    weak var listener: MapListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: MapPresentable, cctvUseCase: CCTVUseCase) {
        self.cctvUseCase = cctvUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToFloatingActions()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - FloatingActionsListener
    func showCCTVMarkers() {
        presenter.showCCTVMarkers()
    }
    func dismissCCTVMarkers() {
        presenter.dismissCCTVMarkers()
    }
    
    func showPoliceStationMarkers() {
        presenter.showPoliceStationMarkers()
    }
    
    func dismissPoliceStationMarkers() {
        presenter.dismissPoliceStationMarkers()
    }
    
    func showHotPlaceMarkers() {
        presenter.showHotPlaceMarkers()
    }
    
    func dismissHotPlaceMarkers() {
        presenter.dismissHotPlaceMarkers()
    }
    
    func routeToSearchRoute() {
        //
    }
    
    // MARK: - Private
    private let cctvUseCase: CCTVUseCase
    private var cancelBag = Set<AnyCancellable>()
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    private func getCurrentLocation() -> Location? {
        locationManager.location?.toLocation()
    }
}

extension CLLocation {
    func toLocation() -> Location {
        Location(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}
