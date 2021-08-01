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
    
    func changeText() {
        self.text = "Third View"
    }
}
