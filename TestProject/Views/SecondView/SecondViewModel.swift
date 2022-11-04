//
//  SecondViewModel.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Combine

class SecondViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() {
        self.text = "Coordinator"
    }
    
    func navigateToThirdView() {
        (coordinator as? MainCoordinator)?.navigateToThirdView()
    }
    
    func navigateToForthView() {
        (coordinator as? MainCoordinator)?.navigateToForthView()
    }
}
