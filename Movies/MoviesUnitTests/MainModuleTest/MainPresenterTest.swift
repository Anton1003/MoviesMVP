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

//    func testGetSuccesResult() {
//        let film = Film(id: 1, results: [])
//        films.append(film)
//
//        view = MockView()
//        networkService = MockNetworkService(film: film)
//        presenter = MainPresenter(view: view, networkingService: networkService as! NetworkServiceProtocol, router: <#T##RouterProtocol#>, photoLoader: <#T##PhotoLoaderProtocol#>, realmProvider: <#T##RealmProviderProtocol#>)
//
//        var catchFilm: Film?
//
//        networkService.getMovies { result in
//            catchFilm = result
//        }
//
//        XCTAssertNotEqual(catchFilm?.id, 0)
//    }
}
