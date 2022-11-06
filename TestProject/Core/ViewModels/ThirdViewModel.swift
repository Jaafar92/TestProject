import Combine
import CoordinatorNavigation

class ThirdViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() {
        self.text = "Third View"
    }
    
    func navigateOneBack() {
        (coordinator as? MainCoordinator)?.navigateBack()
    }
    
    func navigateBackNoHistory() {
        (coordinator as? MainCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
}
