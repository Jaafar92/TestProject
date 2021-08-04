//
// Created by Jaafar on 03/08/2021.
//

import Foundation

class BananaViewModel {

    weak var coordinator: FruitCoordinator?
    
    func navigateToRoot() {
        coordinator?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
}
