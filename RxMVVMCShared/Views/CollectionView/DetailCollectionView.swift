import UIKit

public class DetailCollectionView: UICollectionView {
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    
    // MARK: Mutable
    
    var itemSize: CGSize {
        return (collectionViewLayout as? DetailCollectionViewLayout)?.elementSize ?? .zero
    }
    
     // MARK: - Initializers
    
    public init(frame: CGRect = .zero,
                collectionViewLayout: DetailCollectionViewLayout = DetailCollectionViewLayout()) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setups
    
    private func setup() {
        isPagingEnabled = true
        contentInsetAdjustmentBehavior = .never
        contentInset = .zero
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
    }
}
