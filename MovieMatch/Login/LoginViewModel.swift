//
//  LoginViewModel.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginViewModelDelegate: ViewModel {
    
}

class LoginViewModelImp: LoginViewModelDelegate {
    var repository: LoginRepository
    weak var view: LoginViewDelegate?
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
}
