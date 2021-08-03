//
//  FirstViewCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import UIKit

enum navigationFlag {
    case none, clearHistory
}

protocol MainCoordinatorDelegate: AnyObject {
    func navigateToSecondView()
    func navigateToThirdView(withFlag navigationFlag: navigationFlag)
    func navigateToForthView()
    func navigateToFifthView()
    func navigateBack()
    func navigateBackToRootClearHistory()
    func dismiss()
}

class MainCoordinator : Coordiantor {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        let firstViewController = FirstViewController(viewModel: viewModel)
        
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
    
    func navigateToThirdView(withFlag navigationFlag: navigationFlag) {
        let viewModel = ThirdViewModel()
        viewModel.coordinator = self
        let thirdViewController = ThirdViewController(viewModel: viewModel)
        
        if navigationFlag == .clearHistory {
            let viewControllersToManage: [UIViewController] = [thirdViewController]
            self.navigationController.setViewControllers(viewControllersToManage, animated: true)
            return
        }
        
        self.navigationController.pushViewController(thirdViewController, animated: true)
    }
    
    func navigateToForthView() {
        let viewModel = ForthViewModel()
        viewModel.coordinator = self
        
        let forthViewHostingController = ForthViewHostingViewController(viewModel: viewModel)
        self.navigationController.pushViewController(forthViewHostingController, animated: true)
    }
    
    func navigateToFifthView() {
        let viewModel = FifthViewModel()
        viewModel.coordinator = self
        let fifthViewHostingController = FifthViewHostingController(viewModel: viewModel)
        
        self.navigationController.present(fifthViewHostingController, animated: true, completion: nil)
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateBackToRootClearHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
