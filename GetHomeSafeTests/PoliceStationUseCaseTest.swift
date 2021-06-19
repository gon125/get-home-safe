//
//  PoliceStationUseCaseTest.swift
//  GetHomeSafeTests
//
//  Created by Geonhyeong LIm on 2021/05/25.
//

import XCTest
@testable import GetHomeSafe
import Combine

class PoliceStationUseCaseTest: XCTestCase {
    let policeStationUseCase = DefaultPoliceStationUseCase(repository: DefaultPoliceStationRepository())

    func testGetPoliceStationWithLocationReturnsWithin10Seconds() throws {
        let location = Location(latitude: 35.8888, longitude: 128.6103)
        var policeStations: [PoliceStation]?
        let expectation = self.expectation(description: "PoliceStationUseCase")
        let cancellable = policeStationUseCase.getPoliceStations(near: location)
            .sink {
                policeStations = $0
                expectation.fulfill()
            }
        waitForExpectations(timeout: 10)
        cancellable.cancel()
        XCTAssertNotEqual(policeStations, nil)
    }

}
