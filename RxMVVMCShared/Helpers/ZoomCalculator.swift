import UIKit

 enum ZoomScaleCalculator {
    static func calculateMinZoomScale(viewSize: CGSize, imageSize: CGSize) -> CGFloat {
        guard imageSize.width > 0, imageSize.height > 0 else { return 1 }
        
        let widthScale = viewSize.width / imageSize.width
        let heightScale = viewSize.height / imageSize.height
        
        return min(widthScale, heightScale)
    }
    
    static func transformToInitialZoom(rect: CGRect, scale: CGFloat, by factor: CGFloat) -> (newRect: CGRect, newScale: CGFloat)? {
        if factor.isNormal {
            var result: (newRect: CGRect, newScale: CGFloat)
            result.newRect = rect.applying(CGAffineTransform(scaleX: 1 / factor, y: 1 / factor))
            result.newScale = scale * factor
            return result
        }
        
        return nil
    }
}
