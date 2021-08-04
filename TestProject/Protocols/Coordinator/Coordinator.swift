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
    
    /**
     The parent and child is used to recursively remove any child-coordinators, this was de-initializing them.
     */
    func navigateBackToRootClearHistory(parent: Coordinator?, child: Coordinator?)
}
