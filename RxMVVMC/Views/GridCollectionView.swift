import UIKit

class GridCollectionView: UICollectionView {

    // MARK: - Properties
    // MARK: Immutable
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    
//    // MARK: Mutable
//
    var itemSize: CGSize {
        return flowLayout.itemSize
    }
    
    
    // MARK: - Initializers
    
    init(frame: CGRect = .zero, itemSize: CGSize, minimumPadding: CGFloat) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupFlowLayout(itemSize: itemSize, minimumPadding: minimumPadding)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setup() {
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(inset: LayoutConstants.defaultPadding)
    }
    
    private func setupFlowLayout(itemSize: CGSize, minimumPadding: CGFloat) {
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = itemSize
        flowLayout.minimumInteritemSpacing = minimumPadding
        flowLayout.minimumLineSpacing = minimumPadding
    }
}
