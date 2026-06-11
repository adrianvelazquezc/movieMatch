//
//  DependencyContainer.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

class DependencyContainer {
    init() {}
}

protocol SplashFactory {
    func makeSplashViewController(coordinator: SplashCoordinator) -> SplashViewController
    func makeSplashViewModel() -> SplashViewModelImp
    func makeSplashRepository() -> SplashRepository
}

extension DependencyContainer: SplashFactory {
    func makeSplashViewController(coordinator: SplashCoordinator) -> SplashViewController {
        let viewModel = makeSplashViewModel()
        let view = SplashViewController(coordinator: coordinator, viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func makeSplashViewModel() -> SplashViewModelImp {
        let repository = makeSplashRepository()
        return SplashViewModelImp(repository: repository)
    }
    
    func makeSplashRepository() -> SplashRepository {
        return SplashRepository()
    }
    
    // Generación del coordinador raíz
    func makeMainCoordinator(navigationController: MainNavigationController) -> MainCoordinator {
        return MainCoordinatorImpl(dependencyContainer: self, navigationController: navigationController)
    }
}
