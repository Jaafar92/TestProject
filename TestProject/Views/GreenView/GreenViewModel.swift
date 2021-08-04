//
//  GreenViewModel.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

class GreenViewModel : BaseViewModel {
        
    weak var coordinator: ColorCoordinator?
    
    func navigateToYellowView() {
        coordinator?.navigateToYellowView()
    }
}
