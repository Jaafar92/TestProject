//
//  FifthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

class FifthViewModel : BaseViewModel {
    
    weak var coordinator: MainCoordinator?
    
    func dissmiss() {
        coordinator?.dismiss()
    }
}
