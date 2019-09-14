import UIKit
import Kingfisher
import RxMVVMCShared

class PhotoDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let viewModel: PhotoDetailViewModel
    
    private lazy var collectionView: DetailCollectionView = {
        let collectionView = DetailCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(PhotoDetailCell.self)
        
        return collectionView
    }()
    
    
    // MARK: - Initializers
    
    init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubView()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.scrollToItem(at: viewModel.currenIndexPath, at: .centeredHorizontally, animated: false)
    }
    
    
    // MARK: - Setups
    
    private func setupView() {
        title = viewModel.photo(at: viewModel.currenIndexPath)?.title
        view.backgroundColor = .black
    }
    
    private func setupSubView() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.pinEdges(to: view.safeAreaLayoutGuide)
    }
    
    
    // MARK: - Protocol Conformance
    // MARK: UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoDetailCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let photo = viewModel.photos[indexPath.row]
        title = photo.title
        cell.photo = photo
        
        return cell
    }
}
