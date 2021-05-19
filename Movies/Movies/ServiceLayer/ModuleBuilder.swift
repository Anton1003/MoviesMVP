//
//  ModuleBuilder.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(film: Movie?) -> UIViewController
}

final class ModuleBuilder: BuilderProtocol {
    private let networkService = NetworkService()
    private let photoLoader = PhotoService()
    private let realmProvider = RealmService()

    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MoviesController.self)
        let presenter = MainPresenter(
            view: view,
            networkingService: networkService,
            router: router,
            photoLoader: photoLoader,
            realmProvider: realmProvider
        )
        view.presenter = presenter
        return view
    }

    func createDetailModule(film: Movie?) -> UIViewController {
        let view = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(DetailController.self)
        let presenter = DetailPresenter(
            view: view,
            networkingService: networkService,
            photoLoader: photoLoader,
            realmProvider: realmProvider,
            film: film
        )
        view.presenter = presenter
        return view
    }
}
