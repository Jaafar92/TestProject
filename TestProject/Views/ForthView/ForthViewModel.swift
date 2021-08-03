//
//  ForthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Combine

class ForthViewModel : ObservableObject {
    @Published var text: String = "Forth View"
    
    var coordinator: MainCoordinatorDelegate?
    
    func changeText() {
        self.text = "Changed text in SwiftUI and Combine"
    }
    
    func navigateToThirdView() {
        coordinator?.navigateToThirdView(withFlag: .none)
    }
    
    func navigateOneBack() {
        coordinator?.navigateBack()
    }
    
    func navigateToRootNoHistory() {
        coordinator?.navigateBackToRootClearHistory()
    }
    
    func navigateToThirdAndClearHistory() {
        coordinator?.navigateToThirdView(withFlag: .clearHistory)
    }
    
    func navigateToFifthView() {
        coordinator?.navigateToFifthView()
    }
}
