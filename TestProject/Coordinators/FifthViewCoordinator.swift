//
//  FifthViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

import UIKit

class FifthViewCoordinator: Coordiantor {
    private let navigationController: UINavigationController
    private var fifthViewHostingController: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FifthViewModel()
        let fifthViewHostingController = FifthViewHostingController(viewModel: viewModel)
        
        self.navigationController.present(fifthViewHostingController, animated: true, completion: nil)
    }
}
