//
//  SearchRequestBuilder.swift
//  GetHomeSafe
//
//  Created by khs on 2021/06/02.
//

import RIBs

protocol SearchRequestDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchRequestComponent: Component<SearchRequestDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchRequestBuildable: Buildable {
    func build(withListener listener: SearchRequestListener) -> SearchRequestRouting
}

final class SearchRequestBuilder: Builder<SearchRequestDependency>, SearchRequestBuildable {

    override init(dependency: SearchRequestDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchRequestListener) -> SearchRequestRouting {
        let component = SearchRequestComponent(dependency: dependency)
        let viewController = SearchRequestViewController()
        let interactor = SearchRequestInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchRequestRouter(interactor: interactor, viewController: viewController)
    }
}
