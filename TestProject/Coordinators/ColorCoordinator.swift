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

class ColorCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("ColorCoordinator was de-initialized")
    }
    
    func start() {
        let viewModel = GreenViewModel()
        viewModel.coordinator = self
        let view = GreenView(viewModel: viewModel)
        
        let greenHostingController = GreenHostingViewController(view: view)
        greenHostingController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        self.navigationController.pushViewController(greenHostingController, animated: true)
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // From ViewController is the ViewController that is being navigated "back" from
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        // If our NavigationController still has this ViewController in the list, that means we are moving forward and not backwards, thus we return
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // Now we check if "FromViewController" is the first ViewController of any of the possible child coordinators
        if let greenHostingController = fromViewController as? BananaHostingViewController {
            childDidFinish(greenHostingController.swiftUIView.rootView.viewModel.coordinator)
        }
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
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
