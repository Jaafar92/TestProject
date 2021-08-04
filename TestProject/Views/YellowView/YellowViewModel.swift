//
//  YellowViewModel.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

class YellowViewModel : BaseViewModel {
    weak var coordinator: ColorCoordinator?
    
    func navigateToRoot() {
        coordinator?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
    
    func navigateToBananaView() {
        coordinator?.navigateToBananaView()
    }
    
    func navigateToMainView() {
        coordinator?.navigateToMainView()
    }
}
