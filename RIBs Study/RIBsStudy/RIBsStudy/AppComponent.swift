//
//  AppComponent.swift
//  RIBsStudy
//
//  Created by Geonhyeong LIm on 2021/04/01.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}
