//
//  ForthViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import UIKit

class ForthViewCoordinator : Coordiantor {
    
    private let navigationController: UINavigationController
    private var forthViewHostingController: ForthViewHostingViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ForthViewModel()
        viewModel.coordinator = self
        let forthViewHostingController = ForthViewHostingViewController(viewModel: viewModel)
        
        self.forthViewHostingController = forthViewHostingController
        self.navigationController.pushViewController(forthViewHostingController, animated: true)
    }
}

extension ForthViewCoordinator : ForthViewCoordinatorDelegate {
    func navigateToThirdView() {
        let thirdViewCoordinator = ThirdViewCoordinator(navigationController: self.navigationController)
        thirdViewCoordinator.start()
    }
    
    func navigateOneBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateToRootNoHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func navigateToThirdAndClearHistory() {
        let thirdViewCoordinator = ThirdViewCoordinator(navigationController: self.navigationController)
        thirdViewCoordinator.startAndClearHistory()
    }
    
    func navigateToFifthView() {
        let fifthViewCoordinator = FifthViewCoordinator(navigationController: self.navigationController)
        fifthViewCoordinator.start()
    }
}
