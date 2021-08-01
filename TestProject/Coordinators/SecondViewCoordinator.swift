//
//  SecondViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

class SecondViewCoordinator: Coordiantor {
    
    private let navigationController: UINavigationController
    private var secondViewController: SecondViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewController = SecondViewController()
        secondViewController.coordinator = self
        
        self.secondViewController = secondViewController
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}

extension SecondViewCoordinator : SecondViewCoordinatorDelegate {
    func navigateToForthView() {
        let forthViewCoordinator = ForthViewCoordinator(navigationController: self.navigationController)
        forthViewCoordinator.start()
    }
    
    func navigateToThirdView() {
        let thirdViewCoordinator = ThirdViewCoordinator(navigationController: self.navigationController)
        thirdViewCoordinator.start()
    }
}
