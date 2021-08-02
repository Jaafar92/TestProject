//
//  ThirdViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Foundation
import Combine

class ThirdViewModel {
    @Published var text: String = ""
    
    var coordinator: ThirdViewCoordinatorDelegate?
    
    func changeText() {
        self.text = "Third View"
    }
    
    func navigateOneBack() {
        coordinator?.navigateOneBack()
    }
    
    func navigateBackNoHistory() {
        coordinator?.navigateBackNoHistory()
    }
}
