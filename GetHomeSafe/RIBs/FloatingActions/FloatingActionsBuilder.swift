//
//  FloatingActionsBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import RIBs

protocol FloatingActionsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FloatingActionsComponent: Component<FloatingActionsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FloatingActionsBuildable: Buildable {
    func build(withListener listener: FloatingActionsListener) -> FloatingActionsRouting
}

final class FloatingActionsBuilder: Builder<FloatingActionsDependency>, FloatingActionsBuildable {

    override init(dependency: FloatingActionsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FloatingActionsListener) -> FloatingActionsRouting {
        _ = FloatingActionsComponent(dependency: dependency)
        let viewController = FloatingActionsViewController()
        let interactor = FloatingActionsInteractor(presenter: viewController)
        interactor.listener = listener
        return FloatingActionsRouter(interactor: interactor, viewController: viewController)
    }
}
