//
//  MainPresenter.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func succes()
}

protocol MainViewPresenterProtocol: AnyObject {
    var films: [Movie]? { get set }
    init(
        view: MainViewProtocol,
        networkingService: NetworkServiceProtocol,
        router: RouterProtocol,
        photoLoader: PhotoLoaderProtocol,
        realmProvider: RealmProviderProtocol
    )
    func getFilms()
    func tapOnTheFilm(film: Movie?)
    func loadImage(by path: String?, completion: @escaping (UIImage?) -> ())
}

final class MainPresenter: MainViewPresenterProtocol {
    private weak var view: MainViewProtocol?
    private var networkingService: NetworkServiceProtocol!
    private var router: RouterProtocol?
    private var photoLoader: PhotoLoaderProtocol?
    private var realmProvider: RealmProviderProtocol?
    var films: [Movie]?

    init(
        view: MainViewProtocol,
        networkingService: NetworkServiceProtocol,
        router: RouterProtocol,
        photoLoader: PhotoLoaderProtocol,
        realmProvider: RealmProviderProtocol
    ) {
        self.view = view
        self.networkingService = networkingService
        self.router = router
        self.photoLoader = photoLoader
        self.realmProvider = realmProvider
        getFilms()
    }

    func tapOnTheFilm(film: Movie?) {
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

    func loadImage(by path: String?, completion: @escaping (UIImage?) -> ()) {
        guard let posterPath = path else { return }
        photoLoader?.getPhoto(by: posterPath, runQueue: .global(), completionQueue: .main) { image in
            completion(image)
        }
    }
}
