//
//  RouteRepositoryTests.swift
//  GetHomeSafeTests
//
//  Created by Geonhyeong LIm on 2021/06/03.
//

import XCTest
@testable import GetHomeSafe

class RouteRepositoryTests: XCTestCase {

    func testGetOneRouteInSixSeconds() throws {
        let repository: RouteRepository = DefaultRouteRepository()
        let start = Location(latitude: 37.35970, longitude: 127.1058342)
        let goal = Location(latitude: 35.179470, longitude: 129.075986)
        var output: Route?
        let expectation = expectation(description: "received")

        let cancellable = repository.getRoute(from: start, to: goal)
            .replaceError(with: Route?.none)
            .sink {
                output = $0
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 6)
        cancellable.cancel()
        XCTAssertNotNil(output)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
