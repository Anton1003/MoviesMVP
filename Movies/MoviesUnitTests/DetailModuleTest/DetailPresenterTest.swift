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
    func setFilm(film: Movie?) {
        
    }
    
    func success() {}

    func failure(_ error: Error) {}
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
}
