//
//  FirstViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

class FirstViewCoordinator : Coordiantor {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        let firstViewController = FirstViewController(viewModel: viewModel)
        
        navigationController.pushViewController(firstViewController, animated: true)
    }
}

extension FirstViewCoordinator : FirstViewCoordinatorDelegate {
    func navigateToSecondView() {
        let secondCoordinator = SecondViewCoordinator(navigationController: self.navigationController)
        secondCoordinator.start()
    }
}
