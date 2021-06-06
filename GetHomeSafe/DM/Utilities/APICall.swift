//
//  APICall.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queries: [String: String]? { get }
    func body() throws -> Data?
}

enum APIError: CustomError {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APICall {
    func urlRequset(baseURL: String) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL + self.path) else { throw APIError.invalidURL }
        urlComponents.queryItems = queries?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else { throw APIError.invalidURL }
        var requset = URLRequest(url: url)
        requset.httpMethod = method
        requset.allHTTPHeaderFields = headers
        requset.httpBody = try body()
        return requset
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
