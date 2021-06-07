//
//  SearchRouteUseCaseTests.swift
//  GetHomeSafeTests
//
//  Created by Geonhyeong LIm on 2021/06/02.
//

import XCTest
@testable import GetHomeSafe

class SearchRouteUseCaseTests: XCTestCase {

    func testGetRouteInFourSeconds() throws {
        let usecase: SearchRouteUseCase = DefaultSearchRouteUseCase(repository: DefaultRouteRepository())
        var result: Route?
        let expectation = expectation(description: "result received")
        let cancellable = usecase.getRoute(
            from: Location(latitude: 37.35970, longitude: 127.1058342),
            to: Location(latitude: 35.179470, longitude: 129.075986))
            .sink { result = $0; expectation.fulfill() }
        wait(for: [expectation], timeout: 4)
        cancellable.cancel()
        XCTAssertNotNil(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
