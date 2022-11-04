//
//  FifthViewModel.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

class FifthViewModel : BaseViewModel {
    func dissmiss() {
        (coordinator as? MainCoordinator)?.dismiss()
    }
}
