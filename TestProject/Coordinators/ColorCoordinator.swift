//
//  ColorCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit

protocol ColorCoordinatorDelegate {
    func navigateToYellowView()
    func navigateToBananaView()
}

class ColorCoordinator : Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = GreenViewModel()
        viewModel.coordinator = self
        let view = GreenView(viewModel: viewModel)
        
        let greenHostingController = GreenHostingViewController(view: view)
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
    
    func navigateToBananaView() {
        let fruitCoordinator = FruitCoordinator(navigationController: navigationController)
        fruitCoordinator.parentCoordinator = self
        childCoordinators.append(fruitCoordinator)
        fruitCoordinator.start()
    }
}
