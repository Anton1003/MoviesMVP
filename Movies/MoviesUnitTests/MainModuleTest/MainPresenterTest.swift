//
//  MainPresenterTest.swift
//  MoviesUnitTests
//
//  Created by User on 07.05.2021.
//

@testable import Movies
import XCTest

final class MockView: MainViewProtocol {
    func succes() {}
}

final class MockNetworkService: GetFilmServiceProtocol {
    var film: Film!

    init() {}

    convenience init(film: Film?) {
        self.init()
        self.film = film
    }

    func getMovies(completion: @escaping (Film) -> Void) {
        if let film = film {
            completion(film)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            print("ERROR: \(error)")
        }
    }
}

final class MainPresenterTest: XCTestCase {
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: GetFilmServiceProtocol!
    var router: RouterProtocol!
    var films: [Film] = []

    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        let builder = ModuleBuilder()
        router = Router(navigationController: navigationController, builder: builder)
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
}
