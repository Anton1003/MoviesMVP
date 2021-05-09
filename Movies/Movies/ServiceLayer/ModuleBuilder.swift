//
//  ModuleBuilder.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(film: Result?, router: RouterProtocol) -> UIViewController
}

///
class ModuleBuilder: BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MoviesController.self)
        let networkService = NetworkService()
        let photoLoader = PhotoLoader()
        let realmProvider = RealmProvider()
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

    func createDetailModule(film: Result?, router: RouterProtocol) -> UIViewController {
        let view = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(DetailController.self)
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkingService: networkService, router: router, film: film)
        view.presenter = presenter
        return view
    }
}
