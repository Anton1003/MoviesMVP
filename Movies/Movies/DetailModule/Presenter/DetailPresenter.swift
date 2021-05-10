//
//  DetailPresenter.swift
//  Movies
//
//  Created by User on 07.05.2021.
//

import UIKit
protocol DetailViewProtocol: AnyObject {
    func setFilm(film: Movie?)
    func success()
    func failure(_ error: Error)
}

protocol DetailViewPresenterProtocol: AnyObject {
    var imageArray: [UIImage?] { get set }
    var film: Movie? { get set }
    init(
        view: DetailViewProtocol,
        networkingService: NetworkServiceProtocol,
        photoLoader: PhotoLoaderProtocol?,
        realmProvider: RealmProviderProtocol,
        film: Movie?
    )
    func setFilm()
}

final class DetailPresenter: DetailViewPresenterProtocol {
    var imageArray: [UIImage?] = []
    var film: Movie?
    private weak var view: DetailViewProtocol?
    private var networkingService: NetworkServiceProtocol!
    private var photoLoader: PhotoLoaderProtocol?
    private var realmProvider: RealmProviderProtocol?

    required init(
        view: DetailViewProtocol,
        networkingService: NetworkServiceProtocol,
        photoLoader: PhotoLoaderProtocol?,
        realmProvider: RealmProviderProtocol,
        film: Movie?
    ) {
        self.view = view
        self.networkingService = networkingService
        self.photoLoader = photoLoader
        self.realmProvider = realmProvider
        self.film = film
    }

    private func getImageData(for photos: [Photo]) {
        let photoDispatchGroup = DispatchGroup()
        for photo in photos {
            photoDispatchGroup.enter()
            photoLoader?
                .getPhoto(by: photo.filePath, runQueue: .global(), completionQueue: .main) { [weak self] image in
                    guard let self = self else { return }
                    self.imageArray.append(image)
                    photoDispatchGroup.leave()
                }
        }
        photoDispatchGroup.notify(queue: .main) {
            self.view?.success()
        }
    }

    func setFilm() {
        guard let photos = realmProvider?.get(type: Photo.self) else { return }
//                .filter("filmId == %@", film?.id ?? 0) else { return }
        getImageData(for: Array(photos))
        networkingService?.loadPhotos(for: film?.id ?? 0) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(photos):
                    guard let photos = photos else { return }
                    self.getImageData(for: photos)
//                    photos.forEach { $0. = self.film?.id ?? 0 }
                    self.realmProvider?.save(items: photos)
                case let .failure(error):
                    self.view?.failure(error)
                }
            }
        }
        view?.setFilm(film: film)
    }
}
