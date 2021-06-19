//
//  CCTVRepositoryModels.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/08.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let CCTVDTO = try? newJSONDecoder().decode(CCTVDTO.self, from: jsonData)

import Foundation

// MARK: - CCTVDTOElement
struct CCTVDTOElement: Codable {
    let latitude, longitude: Double
}

typealias CCTVDTO = [CCTVDTOElement]
