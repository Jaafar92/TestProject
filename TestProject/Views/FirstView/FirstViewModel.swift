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
    
    func changeText() {
        self.text = "Hello World"
    }
}
