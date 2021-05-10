//
//  DetailPresenterTest.swift
//  MoviesUnitTests
//
//  Created by User on 07.05.2021.
//

@testable import Movies
import XCTest

///
class MockDetailView: DetailViewProtocol {
    func setFilm(film: Result?) {}
}

///
class DetailPresenterTest: XCTestCase {
    var view: MockDetailView!
    var presenter: DetailPresenter!
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
//        let film = Film(id: 2, results: [Result(
//            backdropPath: "Foo",
//            id: 1,
//            overview: "Baz",
//            popularity: 0.1,
//            posterPath: "SomePath",
//            releaseDate: "12-12-12",
//            title: "SomeTitle",
//            voteAverage: 0.2
//        )])
//
//        films.append(film)
//
//        view = MockDetailView()
//        networkService = MockNetworkService(film: film)
//        presenter = DetailPresenter(
//            view: view,
//            networkingService: networkService,
//            router: router,
//            film: film.results.first
//        )
//
//        var catchResult = presenter.setFilm()
//
//        XCTAssertNotEqual(catchResult, 0)
//    }
}
