//
//  SplashViewCoordinator.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

// MARK: - Protocolo de la Vista Base
protocol View: AnyObject {
    func showLoader()
    func hideLoader()
}

extension View {
    func showLoader(){}
    func hideLoader(){}
}

// MARK: - Coordinador del Splash
protocol SplashCoordinator: AnyObject {
    func splashFlowFinished()
}

class SplashCoordinatorImpl: Coordinator, SplashCoordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    
    private let factory: SplashFactory
    
    init(factory: SplashFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
    }
    
    func start() {
        let viewControllerSplash = factory.makeSplashViewController(coordinator: self)
        navigationController.setViewControllers([viewControllerSplash], animated: false)
    }
    
    func splashFlowFinished() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.showLoginFlow()
    }
}
