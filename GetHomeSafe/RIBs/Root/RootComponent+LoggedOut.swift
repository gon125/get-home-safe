//
//  RootComponent+LoggedOut.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/16.
//

import RIBs

/// The dependencies needed from the parent scope of Root to provide for the LoggedOut scope.
protocol RootDependencyLoggedOut: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension RootComponent: LoggedOutDependency { }
