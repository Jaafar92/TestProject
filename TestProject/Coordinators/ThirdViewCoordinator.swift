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
        let viewModel = ThirdViewModel()
        viewModel.coordinator = self
        let thirdViewController = ThirdViewController(viewModel: viewModel)
        
        self.thirdViewController = thirdViewController
        self.navigationController.pushViewController(thirdViewController, animated: true)
    }
}

extension ThirdViewCoordinator : ThirdViewCoordinatorDelegate {
    func navigateOneBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateBackNoHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func startAndClearHistory() {
        let viewModel = ThirdViewModel()
        viewModel.coordinator = self
        let thirdViewController = ThirdViewController(viewModel: viewModel)
        
        let viewControllersToManage: [UIViewController] = [thirdViewController]
        self.thirdViewController = thirdViewController
        self.navigationController.setViewControllers(viewControllersToManage, animated: true)
    }
}
