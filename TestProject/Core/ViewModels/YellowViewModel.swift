import CoordinatorNavigation

class YellowViewModel : BaseViewModel {
    func navigateToRoot() {
        (coordinator as? ColorCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
    
    func navigateToBananaView() {
        (coordinator as? ColorCoordinator)?.navigateToBananaView()
    }
    
    func navigateToMainView() {
        (coordinator as? ColorCoordinator)?.navigateToMainView()
    }
}
