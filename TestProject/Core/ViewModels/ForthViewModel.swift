import Combine
import CoordinatorNavigation

class ForthViewModel : BaseViewModel, ObservableObject {
    @Published var text: String = "Forth View"
    
    func changeText() {
        self.text = "Changed text in SwiftUI and Combine"
    }
    
    func navigateToThirdView() {
        (coordinator as? MainCoordinator)?.navigateToThirdView()
    }
    
    func navigateOneBack() {
        (coordinator as? MainCoordinator)?.navigateBack()
    }
    
    func navigateToRootNoHistory() {
        (coordinator as? MainCoordinator)?.navigateBackToRootClearHistory(parent: coordinator?.parentCoordinator, child: coordinator)
    }
    
    func navigateToGreenView() {
        (coordinator as? MainCoordinator)?.navigateToGreenView()
    }
    
    func navigateToFifthView() {
        (coordinator as? MainCoordinator)?.navigateToFifthView()
    }
}
