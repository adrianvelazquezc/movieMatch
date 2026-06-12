//
//  LoginViewCoordinator.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginCoordinator: ParentCoordinator {
    
}

class LoginCoordinatorImpl: LoginCoordinator {
    var parentCoordinator: ParentCoordinator?
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    private let factory: LoginFactory
    
    init(factory: LoginFactory,
         navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func start() {
        let viewControllerLogin = factory.makeLoginViewController(coordinator: self)
        navigationController.pushViewController(viewControllerLogin, animated: true)
    }
    
    func closeLoginView() {
        navigationController.popViewController(animated: true)
    }
}
