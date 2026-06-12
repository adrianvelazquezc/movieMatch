//
//  LoginView.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    
}

class LoginViewController: UIViewController {
    private let coordinator: LoginCoordinator
    private let viewModel: LoginViewModelDelegate
    
    private var loginUIView: LoginUIView {
        let view = LoginUIView(delegate: self)
        return view
        }
    
    required init(coordinator: LoginCoordinator,
                  viewModel: LoginViewModelDelegate) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
            view = LoginUIView(delegate: self)
        }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension LoginViewController: LoginViewDelegate {
    
}

extension LoginViewController: LoginUIViewDelegate {
    func notifyUserAndPassword(name: String, password: String) {
        viewModel.loginTapped(username: name, password: password)
    }
}
