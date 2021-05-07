//
//  RouterProtocol.swift
//  Movies
//
//  Created by User on 07.05.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(film: Result?)
}

///
class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?

    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetail(film: Result?) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailModule(film: film, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
