//
//  SearchRequestInteractor.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs
import RxSwift

protocol SearchRequestRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchRequestPresentable: Presentable {
    var listener: SearchRequestPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchRequestListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchRequestInteractor: PresentableInteractor<SearchRequestPresentable>, SearchRequestInteractable, SearchRequestPresentableListener {

    weak var router: SearchRequestRouting?
    weak var listener: SearchRequestListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchRequestPresentable) {
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
