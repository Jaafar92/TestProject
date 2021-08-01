//
//  ForthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import Foundation
import Combine

class ForthViewModel : ObservableObject {
    @Published var text: String = "Forth View"
    
    func changeText() {
        self.text = "Changed text in SwiftUI and Combine"
    }
}
