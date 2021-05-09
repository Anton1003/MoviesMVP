//
//  MainPresenter.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
}

protocol MainViewPresenterProtocol: AnyObject {
    var films: [Result]? { get set }
    init(view: MainViewProtocol, networkingService: NetworkServiceProtocol, router: RouterProtocol)
    func getFilms()
    func tapOnTheFilm(film: Result?)
}

///
final class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var networkingService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var films: [Result]?

    required init(view: MainViewProtocol, networkingService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkingService = networkingService
        self.router = router
        getFilms()
    }

    func tapOnTheFilm(film: Result?) {
        router?.showDetail(film: film)
    }

    func getFilms() {
        networkingService.getMovies { [weak self] film in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.films = film.results
                self.view?.succes()
            }
        }
    }
}
