//
//  FirstViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

class FirstViewCoordinator : Coordiantor {

    private let navigationController: UINavigationController
    private var firstViewController: FirstViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        let firstViewController = FirstViewController(viewModel: viewModel)
        
        self.firstViewController = firstViewController
        navigationController.pushViewController(firstViewController, animated: true)
    }
}

extension FirstViewCoordinator : FirstViewCoordinatorDelegate {
    func navigateToSecondView() {
        let secondCoordinator = SecondViewCoordinator(navigationController: self.navigationController)
        secondCoordinator.start()
    }
}
