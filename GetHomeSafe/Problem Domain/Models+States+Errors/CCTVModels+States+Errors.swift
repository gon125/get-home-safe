//
//  CCTVModels+States+Errors.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import Foundation

struct CCTV: Locationable, Identifiable, Equatable {
    var id: String { "\(coordinate.latitude)\(coordinate.longitude)" }
    let coordinate: Coordinate2D
}
