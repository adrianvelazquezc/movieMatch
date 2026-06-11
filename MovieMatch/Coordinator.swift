//
//  Coordinator.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

protocol ParentCoordinator: Coordinator {
    func childDidFinish(_ child: Coordinator?)
}

extension ParentCoordinator {
    func childDidFinish(_ child: Coordinator?) {
        if let childCoordinator = child {
            childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
        }
    }
}

protocol ChildCoordinator: Coordinator {
    func finish(completion: (() -> Void)?)
}
extension ChildCoordinator {
    func popBack(animated: Bool = false) {
       navigationController.popViewController(animated: animated)
    }
}


extension Coordinator {
    func presentOnTopViewController(viewController: UIViewController, animated: Bool) {
        if let presentedViewController = self.navigationController.presentedViewController {
            overOnPresentedViewController(presentedViewController: presentedViewController, viewController: viewController, animated: animated)
        } else {
            self.navigationController.present(viewController, animated: animated)
        }
    }
    
    func overOnPresentedViewController(presentedViewController: UIViewController, viewController: UIViewController, animated: Bool) {
        if let presentedNestedViewController = presentedViewController.presentedViewController {
            presentedNestedViewController.present(viewController, animated: animated)
        } else {
            presentedViewController.present(viewController, animated: animated)
        }
    }
}
