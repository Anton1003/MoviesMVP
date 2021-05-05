//
//  MainPresenter.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes()
    func failure()
}

protocol MainViewPresenterProtocol: AnyObject {
    var films: Film? { get set }
    init(view: MainViewProtocol, networkingService: NetworkServiceProtocol)
    func getFilms()
}

///
class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var networkingService: NetworkServiceProtocol!
    var films: Film?

    required init(view: MainViewProtocol, networkingService: NetworkServiceProtocol) {
        self.view = view
        self.networkingService = networkingService
        getFilms()
    }

    func getFilms() {
        networkingService.getMovies { [weak self] film in
            guard let self = self else { return }
            self.films = film
            self.view?.succes()
        }
    }
}
