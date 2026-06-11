//
//  AppDelegate.swift
//  MovieMatch
//
//  Created by Adrian Velazquez on 11/06/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?
    let navController = MainNavigationController()
    let dependencyContainer = DependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeWindow()
        return true
    }

    private func initializeWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        coordinator = dependencyContainer.makeMainCoordinator(navigationController: navController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        coordinator?.start()
    }
}

class MainNavigationController: UINavigationController, View {
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
}
