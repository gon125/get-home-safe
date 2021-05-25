//
//  HotPlaceUseCaseTest.swift
//  GetHomeSafeTests
//
//  Created by Geonhyeong LIm on 2021/05/25.
//

import XCTest
import Combine
@testable import GetHomeSafe

class HotPlaceUseCaseTest: XCTestCase {
    
    let hotplaceUseCase = DefaultHotPlaceUseCase()
    
    func testGetHotPlacesWithIn10Seconds() throws {
        let location = Location(latitude: 1, longitude: 1)
        var hotplaces: [HotPlace]?
        let expectation = self.expectation(description: "HotPlaceUseCase")
        let cancellable = hotplaceUseCase.getHotPlaces(near: location).sink { hotplaces = $0; expectation.fulfill() }
        waitForExpectations(timeout: 10)
        cancellable.cancel()
        XCTAssertNotEqual(hotplaces, nil)
    }
}
