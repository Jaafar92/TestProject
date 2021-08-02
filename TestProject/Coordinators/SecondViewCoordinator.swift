//
//  SecondViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

class SecondViewCoordinator: Coordiantor {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SecondViewModel()
        viewModel.coordinator = self
        let secondViewController = SecondViewController(viewModel: viewModel)
        
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
