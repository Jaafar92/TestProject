//
//  BaseCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 04/08/2021.
//

import UIKit

class BaseCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(String(describing: self)) was de-initialized")
    }
    
    func start() {
        // Leave empty. Should be overridden by subclasses
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateBackToRootClearHistory(parent: Coordinator?, child: Coordinator?) {
        self.removeCoordinatorFromParent(parent, child)
        self.navigationController.popToRootViewController(animated: true)
    }

    func childDidFinish(_ child: Coordinator?) {

        // Get the index of the child coordinator in its parent coordinators list of childCoordinators
        let index = child?.parentCoordinator?.childCoordinators.firstIndex { coordinator in child === coordinator }

        // Remove the child from the parent' list of childCoordinators
        if let i = index {
            child?.parentCoordinator?.childCoordinators.remove(at: i)
        }
    }

    private func removeCoordinatorFromParent(_ parent: Coordinator?, _ child: Coordinator?) {
        guard let parent = parent else { return }

        for (index, coordinator) in parent.childCoordinators.enumerated() {
            if coordinator === child {
                parent.childCoordinators.remove(at: index)
                break
            }
        }

        removeCoordinatorFromParent(parent.parentCoordinator, parent)
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

        if let firstViewController = fromViewController as? FirstViewController {
            childDidFinish(firstViewController.coordinator)
            return
        }
    }
}
