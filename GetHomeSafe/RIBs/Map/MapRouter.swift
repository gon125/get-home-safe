//
//  MapRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs

protocol MapInteractable: Interactable, FloatingActionsListener, RouteRequestListener {
    var router: MapRouting? { get set }
    var listener: MapListener? { get set }
}

protocol MapViewControllable: ViewControllable {
    func show(floatingActionsView: ViewControllable)
    func popover(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class MapRouter: ViewableRouter<MapInteractable, MapViewControllable>, MapRouting {
    
    // MARK: - MapRouting
    func routeToFloatingActions() {
        let floatingActions = floatingActionsBuilder.build(withListener: interactor)
        attachChild(floatingActions)
        viewController.show(floatingActionsView: floatingActions.viewControllable)
    }
    
    func routeToRouteRequest() {
        if routeRequest == nil {
            let routeRequest = routeRequestBuilder.build(withListener: interactor)
            attachChild(routeRequest)
            self.routeRequest = routeRequest
        }
        guard let routeRequest = routeRequest else { return }
        viewController.popover(viewController: routeRequest.viewControllable)
    }

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: MapInteractable,
         viewController: MapViewControllable,
         floatingActionsBuilder: FloatingActionsBuildable,
         routeRequestBuilder: RouteRequestBuildable) {
        self.floatingActionsBuilder = floatingActionsBuilder
        self.routeRequestBuilder = routeRequestBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Private
    private let floatingActionsBuilder: FloatingActionsBuildable
    private let routeRequestBuilder: RouteRequestBuildable
    private var routeRequest: ViewableRouting?
}
