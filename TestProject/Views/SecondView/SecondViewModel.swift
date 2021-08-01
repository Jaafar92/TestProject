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
    
    func changeText() {
        self.text = "Coordinator"
    }
}
