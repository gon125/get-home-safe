//
//  FloatingActionsRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import RIBs

protocol FloatingActionsInteractable: Interactable {
    var router: FloatingActionsRouting? { get set }
    var listener: FloatingActionsListener? { get set }
}

protocol FloatingActionsViewControllable: ViewControllable {
}

final class FloatingActionsRouter: ViewableRouter<FloatingActionsInteractable, FloatingActionsViewControllable>, FloatingActionsRouting {
    override init(interactor: FloatingActionsInteractable, viewController: FloatingActionsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
