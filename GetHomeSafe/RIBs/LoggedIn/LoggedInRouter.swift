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
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
    
    // MARK: - LoggedInRouting
    func routeToMap() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
            detachChild(currentChild)
        }
        attachMap()
    }

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         mapBuilder: MapBuildable) {
        self.viewController = viewController
        self.mapBuilder = mapBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
//        attachMap()
    }

    func cleanupViews() {
        if let currentChild = currentChild {
            viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    // MARK: - Private
    private let mapBuilder: MapBuildable
    private let viewController: LoggedInViewControllable
    private var currentChild: ViewableRouting?
    
    private func attachMap() {
        let map = mapBuilder.build(withListener: interactor)
        self.currentChild = map
        attachChild(map)
        viewController.present(viewController: map.viewControllable)
    }
}
