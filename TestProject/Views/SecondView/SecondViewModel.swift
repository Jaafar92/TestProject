//
//  SecondViewModel.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Combine

class SecondViewModel {
    @Published var text: String = ""
    
    var coordinator: MainCoordinatorDelegate?
    
    func changeText() {
        self.text = "Coordinator"
    }
    
    func navigateToThirdView() {
        coordinator?.navigateToThirdView(withFlag: .none)
    }
    
    func navigateToForthView() {
        coordinator?.navigateToForthView()
    }
}
