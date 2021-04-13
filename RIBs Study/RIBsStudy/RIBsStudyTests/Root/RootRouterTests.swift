//
//  RootRouterTests.swift
//  RIBsStudyTests
//
//  Created by Geonhyeong LIm on 2021/04/13.
//

@testable import RIBsStudy
import XCTest

final class RootRouterTests: XCTestCase {

    private var router: RootRouter!
    private var interactor: RootInteractableMock!
    private var loggedInBuilder: LoggedInBuildableMock!
    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        
        loggedInBuilder = LoggedInBuildableMock()
        interactor = RootInteractableMock()
        router = RootRouter(interactor: interactor, viewController: RootViewControllableMock(), loggedOutBuilder: LoggedOutBuildableMock(), loggedInBuilder: loggedInBuilder)
    }

    // MARK: - Tests

    func test_routeToExample_invokesToExampleResult() {
        let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
        
        var assignedListener: LoggedInListener? = nil
        loggedInBuilder.buildHandler = { listener in
            assignedListener = listener
            return loggedInRouter
        }
        
        XCTAssertNil(assignedListener)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
        XCTAssertEqual(loggedInRouter.loadCallCount, 0)
        
        router.routeToLoggedIn(withPlayer1Name: "1", player2Name: "2")
        
        XCTAssertTrue(assignedListener === interactor)
        XCTAssertEqual(loggedInBuilder.buildCallCount, 1)
        XCTAssertEqual(loggedInRouter.loadCallCount, 1)
    }
}
