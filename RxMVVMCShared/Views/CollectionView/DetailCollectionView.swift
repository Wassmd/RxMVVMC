import UIKit

public class DetailCollectionView: UICollectionView {
    
    
    
    
    public init(frame: CGRect = .zero,
         collectionViewLayout: HorizontalDetailCollectionViewLayout = HorizontalDetailCollectionViewLayout()) {
        super.init(frame: frame, collectionViewLayout: collectionViewLayout)
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
