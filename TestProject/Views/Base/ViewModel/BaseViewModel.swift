//
//  BaseViewModel.swift
//  TestProject
//
//  Created by Jaafar on 04/08/2021.
//

import Foundation

class BaseViewModel {
    weak var coordinator: Coordinator?
    
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
}
