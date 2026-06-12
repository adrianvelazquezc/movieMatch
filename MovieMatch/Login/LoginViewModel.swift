//
//  LoginViewModel.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginViewModelDelegate: ViewModel {
    var isLoading: ((Bool) -> Void)? { get set }
    var errorMessage: ((String?) -> Void)? { get set }
    var didLoginSucceed: (() -> Void)? { get set }
    
    func loginTapped(username: String, password: String)
}

@MainActor
class LoginViewModelImp: LoginViewModelDelegate {
    
    var repository: LoginRepository
    weak var view: LoginViewDelegate?
    
    var isLoading: ((Bool) -> Void)?
    var errorMessage: ((String?) -> Void)?
    var didLoginSucceed: (() -> Void)?
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func loginTapped(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            self.errorMessage?("Please fill in all fields.")
            return
        }
        
        isLoading?(true)
        errorMessage?(nil)
        
        Task {
            do {
                let _ = try await repository.login(withUser: username, password: password)
                isLoading?(false)
                didLoginSucceed?()
            } catch {
                isLoading?(false)
                errorMessage?(error.localizedDescription)
            }
        }
    }
}
