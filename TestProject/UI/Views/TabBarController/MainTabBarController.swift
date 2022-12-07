//
//  MainTabBarController.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit

class MainTabBarController : UITabBarController {
    private let uwbCoordinator = UwbCoordinator(navigationController: UINavigationController())
    private let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    private let colorCoordinator = ColorCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        uwbCoordinator.start()
        mainCoordinator.start()
        colorCoordinator.start()
        
        self.viewControllers =
        [
            uwbCoordinator.navigationController,
            mainCoordinator.navigationController,
            colorCoordinator.navigationController
        ]
    }
}
