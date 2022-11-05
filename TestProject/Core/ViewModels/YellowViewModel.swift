//
//  YellowViewModel.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

class YellowViewModel : BaseViewModel {
    func navigateToRoot() {
        (coordinator as? ColorCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
    
    func navigateToBananaView() {
        (coordinator as? ColorCoordinator)?.navigateToBananaView()
    }
    
    func navigateToMainView() {
        (coordinator as? ColorCoordinator)?.navigateToMainView()
    }
}
