//
//  SplashViewModel.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

protocol ViewModel {
    
}

protocol SplashViewModelDelegate: ViewModel {
    
}

class SplashViewModelImp: SplashViewModelDelegate {
    var repository: SplashRepository
    weak var view: SplashViewDelegate?
    
    init(repository: SplashRepository) {
        self.repository = repository
    }
}
