//
//  DetailPresenter.swift
//  Movies
//
//  Created by User on 07.05.2021.
//

import Foundation
protocol DetailViewProtocol: AnyObject {
    func setFilm(film: Result?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkingService: NetworkServiceProtocol, router: RouterProtocol, film: Result?)
    func setFilm()
}

///
class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var networkingService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var film: Result?

    required init(
        view: DetailViewProtocol,
        networkingService: NetworkServiceProtocol,
        router: RouterProtocol,
        film: Result?
    ) {
        self.view = view
        self.networkingService = networkingService
        self.router = router
        self.film = film
    }

    func setFilm() {
        view?.setFilm(film: film)
    }
}
