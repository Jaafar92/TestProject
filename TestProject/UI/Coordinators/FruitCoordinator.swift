//
// Created by Jaafar on 03/08/2021.
//

import UIKit

class FruitCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = BananaViewModel()
        viewModel.coordinator = self
        let view = BananaView(viewModel: viewModel)
        
        let bananaHostingViewController = BananaHostingViewController(view: view)
        self.navigationController.pushViewController(bananaHostingViewController, animated: true)
        
        registerStart(view: bananaHostingViewController)
    }
}
