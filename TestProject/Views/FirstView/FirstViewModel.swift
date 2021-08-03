//
//  FirstViewViewModel.swift
//  TestProject
//
//  Created by Jaafar on 29/07/2021.
//

import Combine

class FirstViewModel {
    @Published var text: String = ""
    
    var coordinator: MainCoordinatorDelegate?
    
    func changeText() {
        self.text = "Hello World"
    }
    
    func navigateToSecondView() {
        coordinator?.navigateToSecondView()
    }
}
