//
//  MainCoordinator.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol MainCoordinator: ParentCoordinator {
    func showSplashFlow()
    func showLoginFlow()
}

class MainCoordinatorImpl: MainCoordinator, LoginCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let dependencyContainer: DependencyContainer
    
    init(dependencyContainer: DependencyContainer, navigationController: MainNavigationController) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        showSplashFlow()
    }
    
    func showSplashFlow() {
        let splashCoordinator = SplashCoordinatorImpl(factory: dependencyContainer, navigationController: navigationController)
        splashCoordinator.parentCoordinator = self
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
    }
    
    func showLoginFlow() {
        let loginVC = dependencyContainer.makeLoginViewController(coordinator: self)
        navigationController.setViewControllers([loginVC], animated: true)
    }
}
