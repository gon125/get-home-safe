//
//  RouteRequestInteractor.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs
import RxSwift

protocol RouteRequestRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RouteRequestPresentable: Presentable {
    var listener: RouteRequestPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RouteRequestListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RouteRequestInteractor: PresentableInteractor<RouteRequestPresentable>, RouteRequestInteractable, RouteRequestPresentableListener {

    weak var router: RouteRequestRouting?
    weak var listener: RouteRequestListener?

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
}
