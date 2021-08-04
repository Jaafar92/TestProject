//
//  ForthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Combine

class ForthViewModel : ObservableObject {
    @Published var text: String = "Forth View"
    
    weak var coordinator: MainCoordinator?
    
    func changeText() {
        self.text = "Changed text in SwiftUI and Combine"
    }
    
    func navigateToThirdView() {
        coordinator?.navigateToThirdView()
    }
    
    func navigateOneBack() {
        coordinator?.navigateBack()
    }
    
    func navigateToRootNoHistory() {
        coordinator?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
    
    func navigateToGreenView() {
        coordinator?.navigateToGreenView()
    }
    
    func navigateToFifthView() {
        coordinator?.navigateToFifthView()
    }
}
