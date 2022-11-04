//
//  GreenViewModel.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

class GreenViewModel : BaseViewModel {
    func navigateToYellowView() {
        (coordinator as? ColorCoordinator)?.navigateToYellowView()
    }
}
