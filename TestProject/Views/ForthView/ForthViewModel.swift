//
//  ForthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Combine

protocol ForthViewCoordinatorDelegate {
    func navigateToThirdView()
    func navigateOneBack()
    func navigateToRootNoHistory()
    func navigateToThirdAndClearHistory()
    func navigateToFifthView()
}

class ForthViewModel : ObservableObject {
    @Published var text: String = "Forth View"
    
    var coordinator: ForthViewCoordinatorDelegate?
    
    func changeText() {
        self.text = "Changed text in SwiftUI and Combine"
    }
    
    func navigateToThirdView() {
        coordinator?.navigateToThirdView()
    }
    
    func navigateOneBack() {
        coordinator?.navigateOneBack()
    }
    
    func navigateToRootNoHistory() {
        coordinator?.navigateToRootNoHistory()
    }
    
    func navigateToThirdAndClearHistory() {
        coordinator?.navigateToThirdAndClearHistory()
    }
    
    func navigateToFifthView() {
        coordinator?.navigateToFifthView()
    }
}
