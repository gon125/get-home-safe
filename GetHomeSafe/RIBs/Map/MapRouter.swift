//
//  MapRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs

protocol MapInteractable: Interactable {
    var router: MapRouting? { get set }
    var listener: MapListener? { get set }
}

protocol MapViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MapRouter: ViewableRouter<MapInteractable, MapViewControllable>, MapRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MapInteractable, viewController: MapViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
