//
//  LoginViewFactory.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginFactory {
    func makeLoginViewController(coordinator: LoginCoordinator) -> LoginViewController
    func makeLoginViewModel() -> LoginViewModelImp
    func makeLoginRepository() -> LoginRepository
}

extension DependencyContainer: LoginFactory {
    func makeLoginViewController(coordinator: LoginCoordinator) -> LoginViewController {
        let viewModel = makeLoginViewModel()
        let view = LoginViewController(coordinator: coordinator, viewModel: viewModel)
        viewModel.view = view
        return view
    }
    
    func makeLoginViewModel() -> LoginViewModelImp {
        let repository = makeLoginRepository()
        let viewModel = LoginViewModelImp(repository: repository)
        return viewModel
    }
    
    func makeLoginRepository() -> LoginRepository {
        let repository = LoginRepository()
        return repository
    }
}
