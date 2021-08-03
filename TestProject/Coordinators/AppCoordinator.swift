//
//  AppCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

class AppCoordinator: Coordiantor {
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        self.window.rootViewController = navigationController
        
        let firstViewCoordinator = MainCoordinator(navigationController: self.navigationController)
        firstViewCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}
