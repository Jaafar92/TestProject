//
//  SecondViewModel.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Foundation
import Combine

class SecondViewModel {
    @Published var text: String = ""
    
    var coordinator: SecondViewCoordinatorDelegate?
    
    func changeText() {
        self.text = "Coordinator"
    }
    
    func navigateToThirdView() {
        coordinator?.navigateToThirdView()
    }
    
    func navigateToForthView() {
        coordinator?.navigateToForthView()
    }
}
