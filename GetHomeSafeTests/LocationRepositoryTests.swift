//
//  LocationRepositoryTests.swift
//  GetHomeSafeTests
//
//  Created by Geonhyeong LIm on 2021/06/07.
//

import XCTest
@testable import GetHomeSafe

class LocationRepositoryTests: XCTestCase {

    func testGetLocationInSixSeconds() throws {
        let repository: LocationRepository = DefaultLocationRepository()
        let expectation = expectation(description: "received")
        var result: Location?
        let cancellable = repository.getLocation(of: "경북대학교 도서관", near: Location(latitude: 35.88606556553867, longitude: 128.6085761555078))
            .mapError({ error -> Error in
                print(error)
                return error
            })
            .sink { error in
                print(error)
            } receiveValue: {
                result = $0
                expectation.fulfill()
                
            }
        
        wait(for: [expectation], timeout: 6)
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
