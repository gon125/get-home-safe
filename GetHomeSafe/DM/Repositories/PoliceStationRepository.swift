//
//  PoliceStationRepository.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/08.
//

import Foundation
import Combine

protocol PoliceStationRepository {
    func getPoliceStationsNear(currentLocation: Location) -> AnyPublisher<[PoliceStation], Never>
}

typealias DefaultPoliceStationRepository = SpringPoliceStationRepository

struct SpringPoliceStationRepository: WebRepository, PoliceStationRepository {
    let session = URLSession(configuration: .default)
    let baseURL: String = "http://118.45.244.37/api/v1/police"
    
    func getPoliceStationsNear(currentLocation: Location) -> AnyPublisher<[PoliceStation], Never> {
        getPoliceStationDTONear(currentLocation: currentLocation)
            .map {
                $0.map {
                    PoliceStation(coordinate: .init(latitude: $0.latitude, longitude: $0.longitude))
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func getPoliceStationDTONear(currentLocation: Location) -> AnyPublisher<PoliceStationDTO, Never> {
        call(endpoint: API.getPoliceStationDTO(currentLocation: currentLocation))
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
}

extension SpringPoliceStationRepository {
    enum API {
        case getPoliceStationDTO(currentLocation: Location)
    }
}

extension SpringPoliceStationRepository.API: APICall {
    var path: String {
        switch self {
        case .getPoliceStationDTO: return "/reqParam"
        }
    }
    
    var method: String {
        switch self {
        case .getPoliceStationDTO: return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getPoliceStationDTO: return nil
        }
    }
    
    var queries: [String: String]? {
        switch self {
        case let .getPoliceStationDTO(currentLocation): return [
            "longitude": "\(currentLocation.coordinate.longitude)",
            "latitude": "\(currentLocation.coordinate.latitude)"
        ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getPoliceStationDTO: return nil
        }
    }
}
