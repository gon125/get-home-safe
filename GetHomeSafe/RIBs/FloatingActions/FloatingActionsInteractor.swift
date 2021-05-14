//
//  FloatingActionsInteractor.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import RIBs
import Combine

protocol FloatingActionsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FloatingActionsPresentable: Presentable {
    var listener: FloatingActionsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FloatingActionsListener: AnyObject {
    func showCCTVMarkers()
    func dismissCCTVMarkers()
    func showPoliceStationMarkers()
    func dismissPoliceStationMarkers()
    func showHotPlaceMarkers()
    func dismissHotPlaceMarkers()
    func routeToSearchRoute()
}

final class FloatingActionsInteractor: PresentableInteractor<FloatingActionsPresentable>, FloatingActionsInteractable, FloatingActionsPresentableListener {

    weak var router: FloatingActionsRouting?
    weak var listener: FloatingActionsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FloatingActionsPresentable) {
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
    
    // MARK: - FloatingActionsPresentableListener
    func searchRoute() {
        listener?.routeToSearchRoute()
    }
    
    func showCCTVMarkers() {
        listener?.showCCTVMarkers()
    }
    
    func showPoliceStationMarkers() {
        listener?.showPoliceStationMarkers()
    }
    
    func showHotPlaceMarkers() {
        listener?.showHotPlaceMarkers()
    }
    
    func dismissCCTVMarkers() {
        listener?.dismissCCTVMarkers()
    }
    
    func dismissPoliceStationMarkers() {
        listener?.dismissPoliceStationMarkers()
    }
    
    func dismissHotPlaceMarkers() {
        listener?.dismissHotPlaceMarkers()
    }
}
