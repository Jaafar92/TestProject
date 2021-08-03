//
//  YellowViewModel.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

class YellowViewModel {
    weak var coordinator: ColorCoordinator?
    
    func navigateToRoot() {
        coordinator?.navigateBackToRootClearHistory()
    }
    
    func navigateToBananaView() {
        coordinator?.navigateToBananaView()
    }
}
