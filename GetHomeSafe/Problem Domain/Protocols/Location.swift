//
//  Location.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

protocol Location {
    var coordinate: Coordinate2D { get }
}

struct Coordinate2D {
    var latitude: Double
    var longitude: Double
}
