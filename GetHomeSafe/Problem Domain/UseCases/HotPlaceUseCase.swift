//
//  HotPlaceUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/25.
//

import Combine

protocol HotPlaceUseCase: UseCase {
    func getHotPlaces(near currentLocation: Location) -> AnyPublisher<[HotPlace], Never>
}

#if DEBUG
struct StubHotPlaceUseCase: HotPlaceUseCase {
    func getHotPlaces(near currentLocation: Location) -> AnyPublisher<[HotPlace], Never> {
        let hotPlaces = [Coordinate2D].stub(with: currentLocation).map { HotPlace(coordinate: $0)}
        return Just(hotPlaces).eraseToAnyPublisher()
    }
}

typealias DefaultHotPlaceUseCase = StubHotPlaceUseCase
#endif
