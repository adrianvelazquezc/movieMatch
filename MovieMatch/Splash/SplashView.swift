//
//  SplashView.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol SplashViewDelegate: AnyObject {
    
}

class SplashViewController: UIViewController {
    private let coordinator: SplashCoordinator
    private let viewModel: SplashViewModelDelegate
    
    required init(coordinator: SplashCoordinator,
                  viewModel: SplashViewModelDelegate) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .orange
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            coordinator.splashFlowFinished()
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension SplashViewController: SplashViewDelegate {
    
}
