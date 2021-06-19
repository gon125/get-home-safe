//
//  PoliceStationRepositoryModels.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/06/08.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let policeStationDTO = try? newJSONDecoder().decode(PoliceStationDTO.self, from: jsonData)

import Foundation

// MARK: - PoliceStationDTOElement
struct PoliceStationDTOElement: Codable {
    let latitude, longitude: Double
}

typealias PoliceStationDTO = [PoliceStationDTOElement]
