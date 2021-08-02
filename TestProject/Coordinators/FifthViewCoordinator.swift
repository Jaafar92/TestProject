//
//  FifthViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

import UIKit

class FifthViewCoordinator: Coordiantor {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FifthViewModel()
        viewModel.coordinator = self
        let fifthViewHostingController = FifthViewHostingController(viewModel: viewModel)
        
        self.navigationController.present(fifthViewHostingController, animated: true, completion: nil)
    }
}

extension FifthViewCoordinator : FifthViewCoordinatorDelegate {
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
