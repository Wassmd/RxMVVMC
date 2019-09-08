import UIKit
import RxMVVMShared

private enum PhotoGridSteps: CoordinateTo {
    case showDetail(currentPhoto: Photo, photos: [Photo])
    case showAlert(String)
}

class PhotoGridCoordinator: Coordinatable {


    // MARK: - Properties
    // MARK: Immutable
    
    let uniqueId: UUID
    private var window: UIWindow?
    private let navigationController: UINavigationController
    
    
    // MARK: - Mutable
    
    var deallocatable: CoordinatorDeallocatable?
    var childCoordinators = [UUID: Coordinatable]()
    
    private lazy var photoGridViewModel = PhotoGridViewModel()
    private lazy var photoGridViewController: PhotoGridViewController = {
        photoGridViewModel.downloadPhotos()
        let controller = PhotoGridViewController(
            viewModel: photoGridViewModel,
            coordinatorDelegate: self)
        
        return controller
    }()
    
    // MARK: - Initializers

    init(uniqueId: UUID,
         deallocatable: CoordinatorDeallocatable? = nil,
         window: UIWindow?,
         navigationController: UINavigationController = UINavigationController()) {
        self.uniqueId = uniqueId
        self.deallocatable = deallocatable
        self.navigationController = navigationController
        self.window = window
    }
    
    
    // MARK: Protocol Conformance
    // MARK: Coordinatable
    
    func coordinate(to step: CoordinateTo) {
        guard let step = step as? PhotoGridSteps else {
            return
        }
        switch step {
        case .showDetail(let currentPhoto, let photos):
            showPhotoDetail(with: currentPhoto, photos: photos)
        case .showAlert(let message):
            showRequestResponseErrorAlert(with: message)
        }
    }
    
    func start() {
        guard let window = window else { fatalError("window is not set") }
        
        navigationController.setViewControllers([photoGridViewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    // MARK: - Transitions
    
    private func showPhotoDetail(with currentPhoto: Photo, photos: [Photo]) {
        let viewModel = PhotoDetailViewModel(with: currentPhoto, photos: photos)
        let controller = PhotoDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func showRequestResponseErrorAlert(with message: String) {
        UIAlertController.showErrorAlert(message: "The connection to server failed \n \(message)", presentedBy: self.photoGridViewController)
    }
}

extension PhotoGridCoordinator: PhotoGridViewControllerDelegate {
    func showErrorAlert(with message: String) {
        coordinate(to: PhotoGridSteps.showAlert(message))
    }
    
    func showDetail(with currentPhoto: Photo, photos: [Photo]) {
        coordinate(to: PhotoGridSteps.showDetail(currentPhoto: currentPhoto, photos: photos))
    }
}
