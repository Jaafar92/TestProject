//
//  FifthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

protocol FifthViewCoordinatorDelegate {
    func dismiss()
}

class FifthViewModel {
    
    var coordinator: FifthViewCoordinatorDelegate?
    
    func dissmiss() {
        coordinator?.dismiss()
    }
}
