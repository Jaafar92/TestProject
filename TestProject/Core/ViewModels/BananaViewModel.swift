import Foundation
import CoordinatorNavigation

class BananaViewModel : BaseViewModel {
    
    func navigateToRoot() {
        (coordinator as? FruitCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
}
