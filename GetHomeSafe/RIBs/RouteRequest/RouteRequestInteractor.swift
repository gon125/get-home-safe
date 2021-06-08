//
//  RouteRequestInteractor.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import RIBs
import RxSwift
import CoreLocation
import Combine

protocol RouteRequestRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RouteRequestPresentable: Presentable {
    var listener: RouteRequestPresentableListener? { get set }
    func dismiss()
}

protocol RouteRequestListener: class {
    func showRoute(_ route: Route)
}

final class RouteRequestInteractor: PresentableInteractor<RouteRequestPresentable>, RouteRequestInteractable, RouteRequestPresentableListener {

    weak var router: RouteRequestRouting?
    weak var listener: RouteRequestListener?
    @Injected var routeUseCase: SearchRouteUseCase

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RouteRequestPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    func searchRoute(start: String?, destination: String) {
        if let start = start {
            // TODO: start by keyword
        } else {
            guard let location = locationManager.location else { return }
            routeUseCase.getRoute(from: location.toLocation(), to: destination)
                .sink { [weak self] in
                    guard let route = $0 else { return }
                    self?.listener?.showRoute(route)
                    self?.presenter.dismiss()
                }
                .store(in: &cancelBag)
        }
    }
    
    // MARK: - Private
    private lazy var locationManager: CLLocationManager = {
        CLLocationManager()
    }()
    private var cancelBag = Set<AnyCancellable>()
}
