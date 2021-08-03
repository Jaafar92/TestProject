//
//  Coordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func dismiss()
    func navigateBack()
    func navigateBackToRootClearHistory()
}

extension Coordinator {
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateBackToRootClearHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func removeCoordinatorFromParent(_ parent: Coordinator?, _ child: Coordinator?) {
        guard let parent = parent else { return }

        for (index, coordinator) in parent.childCoordinators.enumerated() {
            if coordinator === child {
                parent.childCoordinators.remove(at: index)
                break
            }
        }

        removeCoordinatorFromParent(parent.parentCoordinator, parent)
    }
}
