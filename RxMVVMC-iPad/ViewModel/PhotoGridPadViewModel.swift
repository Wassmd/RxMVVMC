import UIKit
import RxMVVMCShared

class PhotoGridPadViewModel: PhotoGridViewModel {
    
    
    // MARK: - Constants
    
    private enum Constants {
        static let minItemWidth: CGFloat = 200
    }
    
    
    // MARK: - Helper
    
    override func initialItemSize(for viewWidth: CGFloat) -> CGSize {
         return ItemSizeCalculator.calculateItemSize(viewWidth: viewWidth, minItemWidth: Constants.minItemWidth)
    }
}
