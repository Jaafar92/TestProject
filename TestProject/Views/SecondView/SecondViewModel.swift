//
//  SecondViewModel.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Combine

class SecondViewModel : BaseViewModel {
    @Published var text: String = ""
    
    weak var coordinator: MainCoordinator?
    
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
