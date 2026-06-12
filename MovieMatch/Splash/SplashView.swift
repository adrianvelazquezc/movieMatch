//
//  SplashView.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit
import Lottie

protocol SplashViewDelegate: AnyObject {
    
}

class SplashViewController: UIViewController {
    private let coordinator: SplashCoordinator
    private let viewModel: SplashViewModelDelegate
    
    public lazy var animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "Cat-Playing")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .playOnce
        animation.contentMode = .scaleAspectFit
        return animation
    }()
    
    required init(coordinator: SplashCoordinator,
                  viewModel: SplashViewModelDelegate) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .orange
        setConstraints()
    }
    func setConstraints() {
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        animationView.play { (finished) in
            if finished {
                self.coordinator.splashFlowFinished()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension SplashViewController: SplashViewDelegate {
    
}
