//
//  ColorCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit

protocol ColorCoordinatorDelegate {
    func navigateToYellowView()
}

class ColorCoordinator : Coordiantor {
    
    var childCoordiantors: [Coordiantor] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GreenViewModel()
        viewModel.coordinator = self
        let view = GreenView(viewModel: viewModel)
        
        let greenHostingController = BaseUIHostingController(view: view)
        greenHostingController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        self.navigationController.pushViewController(greenHostingController, animated: true)
    }
}

extension ColorCoordinator : ColorCoordinatorDelegate {
    func navigateToYellowView() {
        let viewModel = YellowViewModel()
        viewModel.coordinator = self
        let view = YellowView(viewModel: viewModel)
        
        let yellowHostingController = BaseUIHostingController(view: view)
        self.navigationController.pushViewController(yellowHostingController, animated: true)
    }
}
