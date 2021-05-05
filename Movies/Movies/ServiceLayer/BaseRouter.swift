//
//  BaseRouter.swift
//  Movies
//
//  Created by User on 05.05.2021.
//

import UIKit
///
class BaseRouter: NSObject {
    var controller: UIViewController?

    func show(_ controller: UIViewController) {
        self.controller?.show(controller, sender: nil)
    }

    func present(_ controller: UIViewController) {
        self.controller?.present(controller, animated: true)
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = controller
    }
}
