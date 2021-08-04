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

class MainCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = FirstViewModel()
        viewModel.coordinator = self
        
        let firstViewController = FirstViewController(viewModel: viewModel)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationController.pushViewController(firstViewController, animated: true)
        navigationController.delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // From ViewController is the ViewController that is being navigated "back" from
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        // If our NavigationController still has this ViewController in the list, that means we are moving forward and not backwards, thus we return
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // Now we check if "FromViewController" is the first ViewController of any of the possible child coordinators
        if let greenHostingController = fromViewController as? GreenHostingViewController {
            childDidFinish(greenHostingController.swiftUIView.rootView.viewModel.coordinator)
            return
        }

        if let bananaHostingController = fromViewController as? BananaHostingViewController {
            childDidFinish(bananaHostingController.swiftUIView.rootView.viewModel.coordinator)
            return
        }
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
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
