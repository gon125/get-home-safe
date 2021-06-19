//
//  PoliceStationUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/25.
//

import Foundation
import Combine

protocol PoliceStationUseCase: UseCase {
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

typealias DefaultPoliceStationUseCase = SpringPoliceStationUseCase

struct SpringPoliceStationUseCase: PoliceStationUseCase {
    let repository: PoliceStationRepository
    func getPoliceStations(near currentLocation: Location) -> AnyPublisher<[PoliceStation], Never> {
        repository.getPoliceStationsNear(currentLocation: currentLocation)
    }
}
