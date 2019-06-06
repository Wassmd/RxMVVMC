import UIKit
import RxSwift

protocol PhotoGridViewControllerDelegate: AnyObject {
    func showDetail(with photo: Photo)
    func showErrorAlert(with message: String)
}

class PhotoGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    // MARK: - Properties
    // MARK: Constants
    
    enum Constants {
        static let loadingViewSize = CGSize(square: 80)
        static let defaultPadding: CGFloat = 8
    }
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let viewModel: PhotoGridViewModel
    private let disposeBag = DisposeBag()
    private let coordinatorDelegate: PhotoGridViewControllerDelegate?
    private let loadingIndicator = UIActivityIndicatorView(style: .gray)
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    private let loadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    // MARK: Mutable
    
    private lazy var collectionView: GridCollectionView = {
        let collectionView = GridCollectionView(itemSize: viewModel.initialItemSize(for: view.bounds.width), minimumPadding: LayoutConstants.defaultPadding)
        
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
    
    
    //Mark: Setup
    
    private func setupView() {
        view.backgroundColor = .white
        self.title = "Leopard"
        loadingIndicator.startAnimating()
    }
    
    private func setupSubViews() {
        loadingStackView.addArrangedSubview(loadingIndicator)
        loadingStackView.addArrangedSubview(loadingLabel)
        view.addSubview(collectionView)
        view.addSubview(loadingStackView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoGridCell.self, forCellWithReuseIdentifier: PhotoGridCell.reusableString)
    }
    
    private func setupConstraints() {
        loadingStackView.centerVertically(to: view)
        loadingStackView.centerHorizontally(to: view)
        loadingStackView.pinSize(to: Constants.loadingViewSize)
        collectionView.pinEdges(to: view)
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
                self.coordinatorDelegate?.showErrorAlert(with: $0.localizedDescription)
                self.hideLoadingView()
                self.downloadKittensPhotoFallBack()
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.handleCollectionViewDidSelectCell(at: $0)
            })
            .disposed(by: disposeBag)
        
    }
   
    
    // MARK:- Protocol Conformance
    // MARK: UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rawCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoGridCell.reusableString, for: indexPath)
        guard let cell = rawCell as? PhotoGridCell
            else { return rawCell }
        
        if let photo = viewModel.photoObject(at: indexPath) {
            cell.configureCell(with: photo)
        }
        return cell
    }
    

    //MARK: Actions
    
    private func downloadKittensPhotoFallBack() {
        viewModel.downloadPhotos(isFallBack: true)
    }
    
    
    //MARK: Helper
    
    private func handleCollectionViewDidSelectCell(at indexPath: IndexPath) {
        if let photoObject = viewModel.photoObject(at: indexPath) {
            coordinatorDelegate?.showDetail(with: photoObject)
        }
    }
    
    private func hideLoadingView() {
        loadingStackView.isHidden = true
    }
}
