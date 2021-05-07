//
//  ModuleBuilder.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(film: Result?) -> UIViewController
}

///
class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MoviesController.self)
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkingService: networkService)
        view.presenter = presenter
        return view
    }

    static func createDetailModule(film: Result?) -> UIViewController {
        let view = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(DetailController.self)
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkingService: networkService, film: film)
        view.presenter = presenter
        return view
    }
}
