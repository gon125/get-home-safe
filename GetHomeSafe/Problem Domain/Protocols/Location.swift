//
//  Location.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

protocol Locationable: Equatable {
    var coordinate: Coordinate2D { get }
}

struct Location: Locationable {
    var coordinate: Coordinate2D
    
    init(latitude: Double, longitude: Double) {
        self.coordinate = Coordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Coordinate2D: Equatable {
    var latitude: Double
    var longitude: Double
}
