import CoordinatorNavigation

class FifthViewModel : BaseViewModel {
    func dissmiss() {
        (coordinator as? MainCoordinator)?.dismiss()
    }
}
