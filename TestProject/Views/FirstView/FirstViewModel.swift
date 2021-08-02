//
//  FirstViewViewModel.swift
//  TestProject
//
//  Created by Jaafar on 29/07/2021.
//

import Foundation
import Combine

class FirstViewModel {
    @Published var text: String = ""
    
    var coordinator: FirstViewCoordinatorDelegate?
    
    func changeText() {
        self.text = "Hello World"
    }
    
    func navigateToSecondView() {
        coordinator?.navigateToSecondView()
    }
}
