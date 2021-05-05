//
//  ModuleBuilder.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
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
}

 
