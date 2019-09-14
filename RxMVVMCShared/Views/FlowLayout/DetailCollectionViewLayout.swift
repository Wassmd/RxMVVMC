import UIKit

public class DetailCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let section = 0
    
    // MARK: Mutable
    
    private var collectionViewLayoutAttributes = [UICollectionViewLayoutAttributes]()
    private var contentWidth: CGFloat = 0
    
    var elementSize: CGSize {
        return collectionView?.bounds.size ?? .zero
    }
    
    
    // MARK: - Overrides
    // MARK: Preparation
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: 0)
    }
    
    override public func prepare() {
        guard collectionViewLayoutAttributes.isEmpty,
            let collectionView = collectionView else { return }
        
        contentWidth = 0
        var xOffset: CGFloat = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            
            let origin = CGPoint(x: xOffset, y: 0)
            let frame = CGRect(origin: origin, size: elementSize)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            
            collectionViewLayoutAttributes.append(attributes)
            contentWidth = max(contentWidth, frame.maxX)
            xOffset += elementSize.width
        }
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return collectionViewLayoutAttributes[safe: indexPath.item]
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // Loop through the cache and look for items in the rect
        for attributes in collectionViewLayoutAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override public func invalidateLayout() {
        contentWidth = 0
        collectionViewLayoutAttributes.removeAll()
        super.invalidateLayout()
    }
}
