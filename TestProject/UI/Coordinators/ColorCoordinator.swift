//
//  ColorCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import UIKit
import CoordinatorNavigation

protocol ColorCoordinatorDelegate {
    func navigateToYellowView()
    func navigateToBananaView()
    func navigateToMainView()
}

class ColorCoordinator : BaseCoordinator {
    
    override func start() {
        let viewModel = GreenViewModel()
        viewModel.coordinator = self
        let view = GreenView(viewModel: viewModel)
        
        let greenHostingController = BaseUIHostingController.createHostingController(view: view)
        greenHostingController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        self.navigationController.pushViewController(greenHostingController, animated: true)
        
        registerStart(view: greenHostingController)
    }
}

extension ColorCoordinator : ColorCoordinatorDelegate {
    func navigateToYellowView() {
        let viewModel = YellowViewModel()
        viewModel.coordinator = self
        let view = YellowView(viewModel: viewModel)
        
        let yellowHostingController = BaseUIHostingController.createHostingController(view: view)
        self.navigationController.pushViewController(yellowHostingController, animated: true)
    }
    
    func navigateToBananaView() {
        let fruitCoordinator = FruitCoordinator(navigationController: navigationController)
        fruitCoordinator.parentCoordinator = self
        childCoordinators.append(fruitCoordinator)
        fruitCoordinator.start()
    }
    
    func navigateToMainView() {
        let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
        mainCoordinator.parentCoordinator = self
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
}
