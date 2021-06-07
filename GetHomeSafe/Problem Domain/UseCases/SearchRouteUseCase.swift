//
//  SearchRouteUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import Combine
import Foundation

protocol SearchRouteUseCase: UseCase {
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Never>
    func getRoute(from: Location, to: String) -> AnyPublisher<Route?, Never>
    
}

typealias Route = [Location]

typealias DefaultSearchRouteUseCase = NaverSearchRouteUseCase

#if DEBUG
extension Route {
    static func stub(with currentLocation: Location) -> Route? {
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
    func getRoute(from: Location, to: String) -> AnyPublisher<Route?, Never> {
        Just(Route.stub(with: from)).eraseToAnyPublisher()
    }
    
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Never> {
        Just(Route.stub(with: from)).eraseToAnyPublisher()
    }
}
#endif

// MARK: - Naver Search Route UseCase

struct NaverSearchRouteUseCase: SearchRouteUseCase {

    let routeRepository: RouteRepository
    let locationRepository: LocationRepository
    
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Never> {
        routeRepository.getRoute(from: from, to: to)
            .replaceError(with: .none)
            .eraseToAnyPublisher()
    }
    
    func getRoute(from: Location, to: String) -> AnyPublisher<Route?, Never> {
        locationRepository.getLocation(of: to, near: from)
            .flatMap {
                routeRepository.getRoute(from: from, to: $0)
            }
            .replaceError(with: .none)
            .eraseToAnyPublisher()
            
    }
    
}
