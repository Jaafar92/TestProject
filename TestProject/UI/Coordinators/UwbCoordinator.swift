//
//  UwbCoordinator.swift
//  TestProject
//
//  Created by Jaafar on 07/12/2022.
//

import Foundation
import UIKit
import CoordinatorNavigation

class UwbCoordinator : BaseCoordinator {
    
    override func start() {
        let viewModel = UwbMainViewModel()
        viewModel.coordinator = self
        let view = UwbMainView(viewModel: viewModel)
        
        let uwbHostingController = BaseUIHostingController.createHostingController(view: view)
        uwbHostingController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        self.navigationController.pushViewController(uwbHostingController, animated: true)
        
        registerStart(view: uwbHostingController)
    }
}
