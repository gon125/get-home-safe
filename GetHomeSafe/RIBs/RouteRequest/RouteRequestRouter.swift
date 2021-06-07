//
//  RouteRequestRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import RIBs

protocol RouteRequestInteractable: Interactable {
    var router: RouteRequestRouting? { get set }
    var listener: RouteRequestListener? { get set }
}

protocol RouteRequestViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RouteRequestRouter: ViewableRouter<RouteRequestInteractable, RouteRequestViewControllable>, RouteRequestRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RouteRequestInteractable, viewController: RouteRequestViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
