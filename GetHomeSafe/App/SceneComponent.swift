//
//  AppComponent.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/15.
//

import RIBs
import KeychainAccess

class SceneComponent: Component<EmptyDependency>, RootDependency {
    var authenticationModule: AuthenticationModule
    
    // private static let authenticationModule
    // var authenticationModule: AuthenticationModule =
    
    init() {
        authenticationModule = .init()
        super.init(dependency: EmptyComponent())
    }
}

struct AuthenticationModule {
    var authenticationToken: String {
        get {
            Self.keychain[currentUserKey] ?? ""
        }
        set {
            Self.keychain[currentUserKey] = newValue
        }
        
    }
    // MARK: - Private
    private let currentUserKey = "current"
    private static let bundleIdentifier = "com.github.gon125.GetHomeSafe"
    private static let keychain = Keychain(service: bundleIdentifier)
}
