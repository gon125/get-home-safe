//
//  LoggedOutRouter.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs

protocol LoggedOutInteractable: Interactable, SignUpListener {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

    private let signUpBuilder: SignUpBuildable

    private var currentChild: ViewableRouting?

    init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable, signUpBuilder: SignUpBuildable) {
        self.signUpBuilder = signUpBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
    }

    func routeToSignUp() {
        guard currentChild == nil else { return }
        let signUp = signUpBuilder.build(withListener: interactor)
        self.currentChild = signUp
        attachChild(signUp)
        viewController.present(viewController: signUp.viewControllable)
    }

    func cleanupViews() {
        if let signUp = self.currentChild {
            viewController.dismiss(viewController: signUp.viewControllable)
        }
    }

}
