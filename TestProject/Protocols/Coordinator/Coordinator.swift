//
//  Coordinator.swift
//  TestProject
//
//  Created by Jaafar on 30/07/2021.
//

import Foundation
import UIKit

protocol Coordiantor: AnyObject {
    var childCoordiantors: [Coordiantor] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func dismiss()
    func navigateBack()
    func navigateBackToRootClearHistory()
}

extension Coordiantor {
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func navigateBackToRootClearHistory() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
