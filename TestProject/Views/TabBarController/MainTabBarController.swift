//
//  MainTabBarController.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit

class MainTabBarController : UITabBarController {
    private let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    private let colorCoordinator = ColorCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        mainCoordinator.start()
        colorCoordinator.start()
        self.viewControllers = [mainCoordinator.navigationController, colorCoordinator.navigationController]
    }
}
