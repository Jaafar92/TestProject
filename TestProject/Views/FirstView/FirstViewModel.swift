//
//  FirstViewViewModel.swift
//  TestProject
//
//  Created by Jaafar on 29/07/2021.
//

import Combine

class FirstViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() {
        self.text = "Hello World"
    }
    
    func navigateToSecondView() {
        (coordinator as? MainCoordinator)?.navigateToSecondView()
    }
}
