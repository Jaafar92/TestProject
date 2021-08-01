//
//  ThirdViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import UIKit

class ThirdViewCoordinator : Coordiantor {
    
    private let navigationController: UINavigationController
    private var thirdViewController: ThirdViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let thirdViewController = ThirdViewController()
        thirdViewController.coordinator = self
        
        self.thirdViewController = thirdViewController
        self.navigationController.pushViewController(thirdViewController, animated: true)
    }
}

extension ThirdViewCoordinator : ThirdViewCoordinatorDelegate {
    func goBackOne() {
        self.navigationController.popViewController(animated: true)
    }
    
    func backNoHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func startAndClearHistory() {
        let thirdViewController = ThirdViewController()
        thirdViewController.coordinator = self
        
        let viewControllersToManage: [UIViewController] = [thirdViewController]
        self.thirdViewController = thirdViewController
        self.navigationController.setViewControllers(viewControllersToManage, animated: true)
    }
}
