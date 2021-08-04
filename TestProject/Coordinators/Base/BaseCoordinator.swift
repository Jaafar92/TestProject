//
//  BaseCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 04/08/2021.
//

import UIKit

enum coordinatorType {
    case main, color, fruit
}

class BaseCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: coordinatorType

    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController, type: coordinatorType) {
        self.navigationController = navigationController
        self.type = type
    }
    
    func start() {
        if type == .main {
            let mainCoordinator = MainCoordinator(navigationController: self.navigationController)
            mainCoordinator.start()
            return
        }
        
        if type == .color {
            let colorCoordinator = ColorCoordinator(navigationController: self.navigationController)
            colorCoordinator.start()
        }
        
        if type == .fruit {
            let fruitCoordinator = FruitCoordinator(navigationController: self.navigationController)
            fruitCoordinator.start()
        }
    }
}
