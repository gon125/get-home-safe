//
//  SearchRequestRouter.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs

protocol SearchRequestInteractable: Interactable {
    var router: SearchRequestRouting? { get set }
    var listener: SearchRequestListener? { get set }
}

protocol SearchRequestViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchRequestRouter: ViewableRouter<SearchRequestInteractable, SearchRequestViewControllable>, SearchRequestRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchRequestInteractable, viewController: SearchRequestViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
