import UIKit
import Kingfisher
import RxMVVMShared

class PhotoDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    // MARK: - Properties
    // MARK: Constants
    
    private enum Constants {
        static let imageContainerLeadingAndTrailing: CGFloat = 100
         static let boarderWidth: CGFloat = 100
    }
    
    
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
    
    
    // MARK: - Setups
    
    private func setupView() {
        title = viewModel.currentPhoto.title
        view.backgroundColor = .black
    }
    
    private func setupSubView() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.pinEdges(to: view)
    }
    
    
    // MARK: - Protocol Conformance
    // MARK: UICollectionViewDatasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoDetailCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.photo = viewModel.photos[indexPath.row]
        return cell
    }
    
}
