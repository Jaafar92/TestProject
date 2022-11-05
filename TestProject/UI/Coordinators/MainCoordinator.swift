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

class MainCoordinator : BaseCoordinator {
    
    override func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        
        let firstViewController = FirstViewController(viewModel: viewModel)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationController.pushViewController(firstViewController, animated: true)
        navigationController.delegate = self
        
        registerStart(view: firstViewController)
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
        
        let forthViewHostingController = ForthHostingViewController(view: view)
        self.navigationController.pushViewController(forthViewHostingController, animated: true)
    }
    
    func navigateToFifthView() {
        let viewModel = FifthViewModel()
        viewModel.coordinator = self
        let view = FifthView(viewModel: viewModel)
        
        let fifthViewHostingController = FifthHostingViewController(view: view)
        self.navigationController.present(fifthViewHostingController, animated: true, completion: nil)
    }
    
    func navigateToGreenView() {
        let coordinator = ColorCoordinator(navigationController: self.navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
