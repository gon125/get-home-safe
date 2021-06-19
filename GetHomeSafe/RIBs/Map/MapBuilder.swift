//
//  MapBuilder.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/04/28.
//

import RIBs

protocol MapDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MapComponent: Component<MapDependency>, RouteRequestDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MapBuildable: Buildable {
    func build(withListener listener: MapListener) -> MapRouting
}

final class MapBuilder: Builder<MapDependency>, MapBuildable {

    override init(dependency: MapDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MapListener) -> MapRouting {
        let component = MapComponent(dependency: dependency)
        let viewController = MapViewController(viewModel: .init())
        let interactor = MapInteractor(
            presenter: viewController.viewModel,
            cctvUseCase: DefaultCCTVUseCase(repository: DefaultCCTVRepository()),
            policeStationUseCase: DefaultPoliceStationUseCase(repository: DefaultPoliceStationRepository()),
            hotPlaceUseCase: DefaultHotPlaceUseCase())
        viewController.viewModel.listener = interactor
        let floatingActionsBuilder = FloatingActionsBuilder(dependency: component)
        let routeRequestBuilder = RouteRequestBuilder(dependency: component)
        interactor.listener = listener
        return MapRouter(interactor: interactor, viewController: viewController, floatingActionsBuilder: floatingActionsBuilder, routeRequestBuilder: routeRequestBuilder)
    }
}
