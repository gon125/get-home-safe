//
//  WebRepository.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func call<Value>(
        endpoint: APICall,
        httpCodes: HTTPCodes = .success
    ) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequset(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .tryMap {
                    assert(!Thread.isMainThread)
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIError.unexpectedResponse
                    }
                    
                    guard httpCodes.contains(code) else {
                        throw APIError.httpCode(code)
                    }

                    return $0.data
                }
                .decode(type: Value.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
