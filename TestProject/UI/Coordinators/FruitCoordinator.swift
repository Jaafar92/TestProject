//
// Created by Jaafar on 03/08/2021.
//

import UIKit
import CoordinatorNavigation

class FruitCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = BananaViewModel()
        viewModel.coordinator = self
        let view = BananaView(viewModel: viewModel)
        
        let bananaHostingViewController = BaseUIHostingController.createHostingController(view: view)
        self.navigationController.pushViewController(bananaHostingViewController, animated: true)
        
        registerStart(view: bananaHostingViewController)
    }
}
