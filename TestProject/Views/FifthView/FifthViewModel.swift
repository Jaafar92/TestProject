//
//  FifthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

class FifthViewModel {
    
    var coordinator: MainCoordinatorDelegate?
    
    func dissmiss() {
        coordinator?.dismiss()
    }
}
