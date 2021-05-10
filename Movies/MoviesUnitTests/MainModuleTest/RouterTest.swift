//
//  RouterTest.swift
//  MoviesUnitTests
//
//  Created by User on 07.05.2021.
//

@testable import Movies
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let builder = ModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, builder: builder)
    }

    override func tearDownWithError() throws {
        router = nil
    }

    func testRouter() {
        router.showDetail(film: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailController)
    }
}
