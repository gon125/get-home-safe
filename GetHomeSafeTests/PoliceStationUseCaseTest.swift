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
    let policeStationUseCase = DefaultPoliceStationUseCase()

    func testGetPoliceStationWithLocationReturnsWithin10Seconds() throws {
        let location = Location(latitude: -1, longitude: -1)
        var policeStations: [PoliceStation]?
        let expectation = self.expectation(description: "PoliceStationUseCase")
        let cancellable = policeStationUseCase.getPoliceStations(near: location).sink { policeStations = $0; expectation.fulfill() }
        waitForExpectations(timeout: 10)
        cancellable.cancel()
        XCTAssertEqual(policeStations?.isEmpty, false)
    }

}
