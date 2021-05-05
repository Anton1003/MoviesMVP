//
//  MainRouter.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit

final class MainRouter: BaseRouter {
    func toDetail() {
        let controller = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(DetailController.self)
        present(controller)
    }
}
