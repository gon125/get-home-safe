//
//  CCTVUseCase.swift
//  GetHomeSafe
//
//  Created by Geonhyeong LIm on 2021/05/12.
//

import Foundation
import Combine

protocol CCTVUseCase: UseCase {
    func getCCTVs(near currentLocation: Location) -> AnyPublisher<[CCTV], Never>
}

#if DEBUG
struct StubCCTVUseCase: CCTVUseCase {
    func getCCTVs(near currentLocation: Location) -> AnyPublisher<[CCTV], Never> {
        let cctvs: [CCTV] = [Coordinate2D].stub(with: currentLocation).map { CCTV(coordinate: $0) }
        return Just(cctvs).eraseToAnyPublisher()
    }
}
#endif

typealias DefaultCCTVUseCase = SpringCCTVUseCase

struct SpringCCTVUseCase: CCTVUseCase {
    let repository: CCTVRepository
    func getCCTVs(near currentLocation: Location) -> AnyPublisher<[CCTV], Never> {
        repository.getCCTVsNear(currentLocation: currentLocation)
    }
    
}
