//
// Created by Jaafar on 03/08/2021.
//

import UIKit

class FruitCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("FruitCoordinator was de-initialized")
    }

    func start() {
        let viewModel = BananaViewModel()
        viewModel.coordinator = self
        let view = BananaView(viewModel: viewModel)
        
        let bananaHostingViewController = BananaHostingViewController(view: view)
        self.navigationController.pushViewController(bananaHostingViewController, animated: true)
    }
}
