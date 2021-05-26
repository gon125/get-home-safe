//
//  LoggedInRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs

protocol LoggedInInteractable: Interactable, MapListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable, mapBuilder: MapBuildable) {
        self.viewController = viewController
        self.mapBuilder = mapBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        attachMap()
    }

    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    func routeToMap() {
        detachCurrentChild()
        attachMap()
    }

    private var currentChild: ViewableRouting?
    private let viewController: LoggedInViewControllable
    private let mapBuilder: MapBuildable

    private func attachMap() {
        let map = mapBuilder.build(withListener: interactor)
        self.currentChild = map
        attachChild(map)
        viewController.present(viewController: map.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = currentChild {
            detachChild(currentChild)
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }
}
