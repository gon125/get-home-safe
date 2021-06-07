//
//  RouteRequestBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import RIBs

protocol RouteRequestDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RouteRequestComponent: Component<RouteRequestDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RouteRequestBuildable: Buildable {
    func build(withListener listener: RouteRequestListener) -> RouteRequestRouting
}

final class RouteRequestBuilder: Builder<RouteRequestDependency>, RouteRequestBuildable {

    override init(dependency: RouteRequestDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RouteRequestListener) -> RouteRequestRouting {
        let component = RouteRequestComponent(dependency: dependency)
        let viewController = RouteRequestViewController()
        let interactor = RouteRequestInteractor(presenter: viewController)
        interactor.listener = listener
        return RouteRequestRouter(interactor: interactor, viewController: viewController)
    }
}
