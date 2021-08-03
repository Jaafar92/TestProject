//
//  ThirdViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Combine

class ThirdViewModel {
    @Published var text: String = ""
    
    var coordinator: MainCoordinatorDelegate?
    
    func changeText() {
        self.text = "Third View"
    }
    
    func navigateOneBack() {
        coordinator?.navigateBack()
    }
    
    func navigateBackNoHistory() {
        coordinator?.navigateBackToRootClearHistory()
    }
}
