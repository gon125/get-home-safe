//
//  MapRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs

protocol MapInteractable: Interactable, FloatingActionsListener {
    var router: MapRouting? { get set }
    var listener: MapListener? { get set }
}

protocol MapViewControllable: ViewControllable {
    func show(floatingActionsView: ViewControllable)
}

final class MapRouter: ViewableRouter<MapInteractable, MapViewControllable>, MapRouting {
    
    // MARK: - MapRouting
    func routeToFloatingActions() {
        let floatingActions = floatingActionsBuilder.build(withListener: interactor)
        attachChild(floatingActions)
        viewController.show(floatingActionsView: floatingActions.viewControllable)
    }

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MapInteractable,
         viewController: MapViewControllable,
         floatingActionsBuilder: FloatingActionsBuildable) {
        self.floatingActionsBuilder = floatingActionsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Private
    private let floatingActionsBuilder: FloatingActionsBuildable
}
