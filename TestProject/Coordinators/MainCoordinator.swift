//
//  FirstViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func navigateToSecondView()
    func navigateToThirdView()
    func navigateToForthView()
    func navigateToFifthView()
    
    func navigateToGreenView()
}

class MainCoordinator : Coordiantor {
    
    var childCoordiantors: [Coordiantor] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        
        let firstViewController = FirstViewController(viewModel: viewModel)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationController.pushViewController(firstViewController, animated: true)
    }
}

extension MainCoordinator : MainCoordinatorDelegate {
    
    func navigateToSecondView() {
        let viewModel = SecondViewModel()
        viewModel.coordinator = self
        
        let secondViewController = SecondViewController(viewModel: viewModel)
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
    func navigateToThirdView() {
        let viewModel = ThirdViewModel()
        viewModel.coordinator = self
        
        let thirdViewController = ThirdViewController(viewModel: viewModel)
        self.navigationController.pushViewController(thirdViewController, animated: true)
    }
    
    func navigateToForthView() {
        let viewModel = ForthViewModel()
        viewModel.coordinator = self
        let view = ForthView(viewModel: viewModel)
        
        let forthViewHostingController = BaseUIHostingController(view: view)
        self.navigationController.pushViewController(forthViewHostingController, animated: true)
    }
    
    func navigateToFifthView() {
        let viewModel = FifthViewModel()
        viewModel.coordinator = self
        let view = FifthView(viewModel: viewModel)
        
        let fifthViewHostingController = BaseUIHostingController(view: view)
        self.navigationController.present(fifthViewHostingController, animated: true, completion: nil)
    }
    
    func navigateToGreenView() {
        let coordinator = ColorCoordinator(navigationController: self.navigationController)
        childCoordiantors.append(coordinator)
        coordinator.start()
    }
}
