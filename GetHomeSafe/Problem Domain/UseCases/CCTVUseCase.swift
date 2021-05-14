//
//  CCTVUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import Foundation
import Combine

protocol CCTVUseCase {
    func getCCTVs(near currentLocation: Location) -> AnyPublisher<[CCTV], Never>
}

#if DEBUG
struct StubCCTVUseCase: CCTVUseCase {
    func getCCTVs(near currentLocation: Location) -> AnyPublisher<[CCTV], Never> {
        var coordnates = [Coordinate2D]()
        for _ in 0..<10 {
            coordnates.append(
                Coordinate2D(
                    latitude: currentLocation.coordinate.latitude + Double.random(in: -0.006..<0.006),
                    longitude: currentLocation.coordinate.longitude + Double.random(in: -0.006..<0.006))
            )
        }
        let cctvs: [CCTV] = coordnates.map { CCTV(coordinate: $0) }
        return Just(cctvs).eraseToAnyPublisher()
    }
}
#endif
