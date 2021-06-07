//
//  RouteRepository.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import Combine
import Foundation

protocol RouteRepository {
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Error>
}

typealias DefaultRouteRepository = NaverRouteRepository

#if DEBUG
struct StubRouteRepository: RouteRepository {
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Error> {
        Just(Route.stub(with: from))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif

struct NaverRouteRepository: RouteRepository, WebRepository {
    let session = URLSession(configuration: .default)
    let baseURL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1"
    
    func getRoute(from: Location, to: Location) -> AnyPublisher<Route?, Error> {
        return getDrivingDTO(from: from, to: to)
            .map {
                $0.route.trafast.first?.path.map { Location(latitude: $0[1], longitude: $0[0]) }
            }
            .eraseToAnyPublisher()
    }
    
    private func getDrivingDTO(from: Location, to: Location) -> AnyPublisher<DrivingDTO, Error> {
        return call(endpoint: API.getRoute(from: from, to: to))
    }
}

extension NaverRouteRepository {
    enum API {
        case getRoute(from: Location, to: Location)
    }
}

extension NaverRouteRepository.API: APICall {
    
    var path: String {
        switch self {
        case .getRoute: return "/driving"
        }
    }
    
    var method: String {
        switch self {
        case .getRoute: return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRoute: return [
            "X-NCP-APIGW-API-KEY-ID": Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String ?? "",
            "X-NCP-APIGW-API-KEY": Bundle.main.object(forInfoDictionaryKey: "NMFClientSecret") as? String ?? ""
        ]
        }
    }
    
    var queries: [String: String]? {
        switch self {
        case let .getRoute(from, to): return [
            "start": "\(from.coordinate.longitude),\(from.coordinate.latitude)",
            "goal": "\(to.coordinate.longitude),\(to.coordinate.latitude)",
            "option": "trafast"
        ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getRoute: return nil
        }
    }
}
