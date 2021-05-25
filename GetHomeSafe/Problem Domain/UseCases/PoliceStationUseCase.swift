//
//  PoliceStationUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/25.
//

import Foundation
import Combine

protocol PoliceStationUseCase {
    func getPoliceStations(near currentLocation: Location) -> AnyPublisher<[PoliceStation], Never>
}

#if DEBUG
struct StubPoliceStationUseCase: PoliceStationUseCase {
    func getPoliceStations(near currentLocation: Location) -> AnyPublisher<[PoliceStation], Never> {
        let policeStations = [Coordinate2D].stub(with: currentLocation).map { PoliceStation(coordinate: $0) }
        return Just(policeStations).eraseToAnyPublisher()
    }
}
#endif

typealias DefaultPoliceStationUseCase = StubPoliceStationUseCase
