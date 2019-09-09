import UIKit
import RxSwift
import RxMVVMShared

protocol PhotoGridViewControllerDelegate: AnyObject {
    func showDetail(at indexPath: IndexPath, photos: [Photo])
    func showErrorAlert(with message: String)
}

class PhotoGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    // MARK: - Properties
    // MARK: Constants
    
    private enum Constants {
        static let loadingViewSize = CGSize(square: 80)
        static let defaultPadding: CGFloat = 8
    }
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let viewModel: PhotoGridViewModel
    private let disposeBag = DisposeBag()
    weak var coordinatorDelegate: PhotoGridViewControllerDelegate?
    
    private let loadingView = LoadingView()
    
    // MARK: Mutable
    
    private lazy var collectionView: GridCollectionView = {
        let collectionView = GridCollectionView(itemSize: viewModel.initialItemSize(for: view.bounds.width),
                                                minimumPadding: LayoutConstants.defaultPadding)
        return collectionView
    }()
    
    
    // MARK: - Initializers
    
    init(viewModel: PhotoGridViewModel = PhotoGridViewModel(),
         coordinatorDelegate: PhotoGridViewControllerDelegate?) {
        self.viewModel = viewModel
        self.coordinatorDelegate = coordinatorDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubViews()
        setupConstraints()
        setupObserving()
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .black
        title = "Leopard"
    }
    
    private func setupSubViews() {
        [collectionView, loadingView].forEach(view.addSubview(_:))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoGridCell.self, forCellWithReuseIdentifier: PhotoGridCell.reusableString)
        
        loadingView.show()
    }
    
    private func setupConstraints() {
        collectionView.pinEdges(to: view)
        
        loadingView.pinSize(to: CGSize(square: 80))
        loadingView.centerVertically(to: view)
        loadingView.centerHorizontally(to: view)
    }
    
    
    // MARK: Setup Observing
    
    private func setupObserving() {
        viewModel.photosRelayObserver.asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
                self?.hideLoadingView()
            })
            .disposed(by: disposeBag)
        
        viewModel.errorRelayObserver
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.coordinatorDelegate?.showErrorAlert(with: $0)
                self.hideLoadingView()
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.handleCollectionViewDidSelectCell(at: $0)
            })
            .disposed(by: disposeBag)
        
    }
   
    
    // MARK: - Protocol Conformance
    // MARK: UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rawCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.reusableString, for: indexPath)
        guard let cell = rawCell as? PhotoGridCell
            else { return rawCell }
        
        cell.photo = viewModel.photoObject(at: indexPath)
       
        return cell
    }
    

    // MARK: Actions
    
    private func downloadKittensPhotoFallBack() {
        viewModel.downloadPhotos(isFallBack: true)
    }
    
    
    // MARK: - Helpers
    
    private func handleCollectionViewDidSelectCell(at indexPath: IndexPath) {
        coordinatorDelegate?.showDetail(at: indexPath, photos: viewModel.allPhoto)
    }
    
    private func hideLoadingView() {
        loadingView.hide()
    }
}
