import Combine
import CoordinatorNavigation

class SecondViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() {
        self.text = "Coordinator"
    }
    
    func navigateToThirdView() {
        (coordinator as? MainCoordinator)?.navigateToThirdView()
    }
    
    func navigateToForthView() {
        (coordinator as? MainCoordinator)?.navigateToForthView()
    }
}
