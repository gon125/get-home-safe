//
//  RootBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/16.
//

import RIBs

protocol RootDependency: Dependency {
    
}

final class RootComponent: Component<RootDependency> {
    let rootViewController: RootViewController
    
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
    
    var authenticationUseCase: AuthenticationUseCase {
        StubAuthenticationUseCase()
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let router = RootRouter(interactor: interactor, viewController: viewController, loggedOutBuilder: loggedOutBuilder, loggedInBuilder: loggedInBuilder)
        return router
    }
}
