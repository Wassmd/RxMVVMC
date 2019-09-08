import UIKit

public class DetailCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    // MARK: - Properties
    // MARK: Immutable
    
    private let section = 0
    
    // MARK: Mutable
    
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var contentWidth: CGFloat = 0
    
    var elementSize: CGSize {
        return collectionView?.bounds.size ?? .zero
    }
    
    
    // MARK: - Overrides
    // MARK: Preparation
    
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: 0)
    }
    
    public override func prepare() {
        guard let collectionView = collectionView else { return }
        
        contentWidth = 0
        
        var xOffset: CGFloat = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: item, section: section)
            
            let origin = CGPoint(x: xOffset, y: 0)
            let frame = CGRect(origin: origin, size: elementSize)
            print("elementSize:\(elementSize)")
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            
            contentWidth  = max(contentWidth, frame.maxX)
            
            xOffset += elementSize.width
            
            print("xOffset:\(xOffset)")
        }
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        if let indexPathToShow = indexPathToShow {
//            let originX = layoutAttributes[indexPathToShow.item].frame.origin.x
//            return CGPoint(x: originX, y: proposedContentOffset.y)
//        }
//
        return proposedContentOffset
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[safe: indexPath.item]
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in layoutAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override public func invalidateLayout() {
        contentWidth = 0
        layoutAttributes.removeAll()
        super.invalidateLayout()
    }
}
