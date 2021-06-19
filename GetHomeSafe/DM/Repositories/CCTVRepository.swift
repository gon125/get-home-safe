//
//  CCTVRepository.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/08.
//

import Foundation
import Combine

protocol CCTVRepository {
    func getCCTVsNear(currentLocation: Location) -> AnyPublisher<[CCTV], Never>
}

typealias DefaultCCTVRepository = SpringCCTVRepository

struct SpringCCTVRepository: WebRepository, CCTVRepository {
    let session = URLSession(configuration: .default)
    let baseURL: String = "http://118.45.244.37/api/v1/cctv"
    
    func getCCTVsNear(currentLocation: Location) -> AnyPublisher<[CCTV], Never> {
        getCCTVDTONear(currentLocation: currentLocation)
            .map {
                $0.map {  CCTV(coordinate: .init(latitude: $0.latitude, longitude: $0.longitude))}
            }
            .eraseToAnyPublisher()
    }
    
    private func getCCTVDTONear(currentLocation: Location) -> AnyPublisher<CCTVDTO, Never> {
        call(endpoint: API.getCCTVDTO(currentLocation: currentLocation))
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
}

extension SpringCCTVRepository {
    enum API {
        case getCCTVDTO(currentLocation: Location)
    }
}

extension SpringCCTVRepository.API: APICall {
    var path: String {
        switch self {
        case .getCCTVDTO: return "/reqParam"
        }
    }
    
    var method: String {
        switch self {
        case .getCCTVDTO: return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getCCTVDTO: return nil
        }
    }
    
    var queries: [String: String]? {
        switch self {
        case let .getCCTVDTO(currentLocation): return [
            "longitude": "\(currentLocation.coordinate.longitude)",
            "latitude": "\(currentLocation.coordinate.latitude)"
            
        ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getCCTVDTO: return nil
        }
    }
}
