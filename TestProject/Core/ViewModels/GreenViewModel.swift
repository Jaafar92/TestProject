import CoordinatorNavigation

class GreenViewModel : BaseViewModel {
    
    override init() {
    }
    
    func navigateToYellowView() {
        (coordinator as? ColorCoordinator)?.navigateToYellowView()
    }
}
