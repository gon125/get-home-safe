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

//    let loggedOutViewController: LoggedOutViewController
//
//    init(dependency: LoggedOutDependency,
//         loggedOutViewController: LoggedOutViewController) {
//        self.loggedOutViewController = loggedOutViewController
//        super.init(dependency: dependency)
//    }
    fileprivate var authenticationUseCase: AuthenticationUseCase {
        return dependency.authenticationUseCase
    }
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
        let viewController = LoggedOutViewController()
        let component = LoggedOutComponent(dependency: dependency)

        let interactor = LoggedOutInteractor(presenter: viewController, authenticationUseCase: dependency.authenticationUseCase)
        interactor.listener = listener

        let signUpBuilder = SignUpBuilder(dependency: component)

        return LoggedOutRouter(interactor: interactor, viewController: viewController, signUpBuilder: signUpBuilder)
    }
}
