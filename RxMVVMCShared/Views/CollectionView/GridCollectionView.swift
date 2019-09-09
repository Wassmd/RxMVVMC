import UIKit

public class GridCollectionView: UICollectionView {

    
    // MARK: - Properties
    // MARK: Immutable
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    // MARK: Mutable

    var itemSize: CGSize {
        return flowLayout.itemSize
    }
    
    
    // MARK: - Initializers
    
    public init(frame: CGRect = .zero, itemSize: CGSize, minimumPadding: CGFloat) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupFlowLayout(itemSize: itemSize, minimumPadding: minimumPadding)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setup() {
        backgroundColor = .black
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
