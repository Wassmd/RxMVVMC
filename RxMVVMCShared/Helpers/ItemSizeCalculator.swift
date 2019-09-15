import UIKit

public enum ItemSizeCalculator {
    public static func calculateItemSize(viewWidth: CGFloat, minItemWidth: CGFloat) -> CGSize {
        guard viewWidth > 0 else { return CGSize.zero }
        
        let overallItemSize = minItemWidth + LayoutConstants.defaultPadding
        let numberofItemsPerRow = Int(viewWidth / overallItemSize)
        let paddingSum = CGFloat(numberofItemsPerRow + 1) * LayoutConstants.defaultPadding
        let itemWidth = (viewWidth - paddingSum) / CGFloat(numberofItemsPerRow)
        
        return CGSize(squareLength: itemWidth)
    }
}
