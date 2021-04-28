//
//  LoggedOutBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    var authenticationUseCase: AuthenticationUseCase { get }
}

final class LoggedOutComponent: Component<LoggedOutDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        _ = LoggedOutComponent(dependency: dependency)
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController, authenticationUseCase: dependency.authenticationUseCase)
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor, viewController: viewController)
    }
}
