//
// Created by Jaafar on 03/08/2021.
//

import Foundation

class BananaViewModel : BaseViewModel {
    func navigateToRoot() {
        (coordinator as? FruitCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
}
