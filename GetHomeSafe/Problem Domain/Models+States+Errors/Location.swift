//
//  Location.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

protocol Locationable: Equatable, Identifiable {
    var coordinate: Coordinate2D { get }
}

extension Locationable {
    var id: String { "\(coordinate.latitude)\(coordinate.longitude)" }
}

struct Location: Locationable {
    var name: String?
    var coordinate: Coordinate2D
    
    init(latitude: Double, longitude: Double) {
        self.coordinate = Coordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Coordinate2D: Equatable {
    var latitude: Double
    var longitude: Double
}

#if DEBUG
extension Array where Element == Coordinate2D {
    static func stub(with currentLocation: Location) -> Self {
        var coordnates = [Coordinate2D]()
        for _ in 0..<10 {
            coordnates.append(
                Coordinate2D(
                    latitude: currentLocation.coordinate.latitude + Double.random(in: -0.006..<0.006),
                    longitude: currentLocation.coordinate.longitude + Double.random(in: -0.006..<0.006))
            )
        }
        return coordnates
    }
}
#endif
