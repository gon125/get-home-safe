//
//  LoggedInBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/17.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var LoggedInViewController: LoggedInViewControllable { get }
}

final class LoggedInComponent: Component<LoggedInDependency> {

    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }

    let userID: String
    let userPW: String

    init(dependency: LoggedInDependency, userID: String, userPW: String) {
        self.userID = userID
        self.userPW = userPW
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, userID: String, userPW: String) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, userID: String, userPW: String) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency,
                                          userID: userID, userPW: userPW)
//        let mapBuilder = MapBuilder(dependency: component)
        let interactor = LoggedInInteractor()
        interactor.listener = listener

        return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController/*, mapBuilder: mapBuilder*/)
    }
}
