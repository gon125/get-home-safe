//
//  LoggedOutComponent+SignUp.swift
//  GetHomeSafe
//
//  Created by khs on 2021/05/21.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOut scope.
protocol LoggedOutDependencySignUp: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension LoggedOutComponent: SignUpDependency { }
