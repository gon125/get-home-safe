//
//  LocationRepository.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import Combine
import Foundation

protocol LocationRepository {
    func getLocation(of address: String, near currentLocation: Location) -> AnyPublisher<Location, Error>
}

typealias DefaultLocationRepository = KakaoLocationRepository

#if DEBUG
struct StubLocationRepository: LocationRepository {
    func getLocation(of address: String, near currentLocation: Location) -> AnyPublisher<Location, Error> {
        Just(Location(latitude: 100, longitude: 20))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
#endif

struct KakaoLocationRepository: LocationRepository, WebRepository {
    let session = URLSession(configuration: .default)
    let baseURL = "https://dapi.kakao.com/v2/local/search"
    
    func getLocation(of address: String, near currentLocation: Location) -> AnyPublisher<Location, Error> {
        getKeywordDTO(of: address, near: currentLocation)
            .tryMap {
                guard $0.meta.totalCount != 0 else { throw KakaoError.noValue }
                return $0.documents[0].asLocation
            }
            .eraseToAnyPublisher()
    }
    
    private func getKeywordDTO(of address: String, near currentLocation: Location) -> AnyPublisher<KeywordDTO, Error> {
        call(endpoint: API.getKeywordDTO(address: address, currentLocation: currentLocation))
    }
}

extension KakaoLocationRepository {
    enum KakaoError: Error {
        case noValue
    }
}

extension Document {
    var asLocation: Location {
        Location(latitude: Double(y)!, longitude: Double(x)!)
    }
}

extension KakaoLocationRepository {
    enum API {
        case getKeywordDTO(address: String, currentLocation: Location)
    }
}

extension KakaoLocationRepository.API: APICall {
    var path: String {
        switch self {
        case .getKeywordDTO: return "/keyword.json"
        }
    }
    
    var method: String {
        switch self {
        case .getKeywordDTO: return "GET"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getKeywordDTO: return [
            "Authorization": "KakaoAK " + (Bundle.main.object(forInfoDictionaryKey: "KakaoAPIKey") as? String ?? "")
        ]
        }
    }
    
    var queries: [String: String]? {
        switch self {
        case let .getKeywordDTO(address, currentLocation): return [
            "query": address,
            "y": "\(currentLocation.coordinate.latitude)",
            "x": "\(currentLocation.coordinate.longitude)",
            "radius": "20000"
        ]
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .getKeywordDTO: return nil
        }
    }
}
