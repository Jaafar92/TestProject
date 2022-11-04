//
//  ThirdViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Combine

class ThirdViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() {
        self.text = "Third View"
    }
    
    func navigateOneBack() {
        (coordinator as? MainCoordinator)?.navigateBack()
    }
    
    func navigateBackNoHistory() {
        (coordinator as? MainCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
}
