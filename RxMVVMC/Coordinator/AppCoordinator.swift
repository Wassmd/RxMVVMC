import UIKit
import RxMVVMCShared

enum AppStep: CoordinateTo {
    case showPhotoGridView
}

final class AppCoordinator: Coordinatable {
    

    // MARK: - Properties
    // MARK: Immutable
    
    let uniqueId = UUID()
    weak var deallocatable: CoordinatorDeallocatable?
    private let application: UIApplication
    
    
    // MARK: Mutable
    
    var childCoordinators = [UUID: Coordinatable]()
    private var window: UIWindow?
    
    
    // MARK: - Initializers
    
    init(dismissable: CoordinatorDeallocatable? = nil,
         application: UIApplication = UIApplication.shared) {
        self.deallocatable = dismissable
        self.application = application
        
        setupWindow()
    }
    
    
    // MARK: - Setups
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        (application.delegate as? AppDelegate)?.window = window
    }
    
    
    // MARK: - Protocol Conformance
    // MARK: Coordinatable
    
    func coordinate(to step: CoordinateTo) {
        guard let step = step as? AppStep else { return }
        switch step {
        case .showPhotoGridView:
            showPhotoGridView()
        }
    }
    
    func start() {
        coordinate(to: AppStep.showPhotoGridView)
    }
    
    
     // MARK: - Transitions
    
    private func showPhotoGridView() {
        let uniqueId = UUID()
        let photoGridCoordinator = PhotoGridCoordinator(
            uniqueId: uniqueId,
            deallocatable: self,
            window: window)
        
        photoGridCoordinator.start()
        childCoordinators[uniqueId] = photoGridCoordinator
    }
}
