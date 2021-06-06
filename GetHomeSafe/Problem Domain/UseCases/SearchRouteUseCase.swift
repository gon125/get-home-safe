//
//  SearchRouteUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import Combine
import Foundation

protocol SearchRouteUseCase: UseCase {
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route, Never>
}

typealias Route = [Location]

typealias DefaultSearchRouteUseCase = NaverSearchRouteUseCase

#if DEBUG
extension Route {
    static func stub(with currentLocation: Location) -> Route {
        var coordnates = [Coordinate2D]()
        for _ in 0..<10 {
            coordnates.append(
                Coordinate2D(
                    latitude: currentLocation.coordinate.latitude + Double.random(in: -0.006..<0.006),
                    longitude: currentLocation.coordinate.longitude + Double.random(in: -0.006..<0.006))
            )
        }
        return coordnates.map { Location(latitude: $0.latitude, longitude: $0.longitude) }
    }
}

struct StubSearchRouteUseCase: SearchRouteUseCase {
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route, Never> {
        Just(Route.stub(with: from)).eraseToAnyPublisher()
    }
}
#endif

// MARK: - Naver Search Route UseCase

struct NaverSearchRouteUseCase: SearchRouteUseCase {
    let repository: RouteRepository
    
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route, Never> {
        repository.getRoute(from: from, to: to)
            .replaceNil(with: [])
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
