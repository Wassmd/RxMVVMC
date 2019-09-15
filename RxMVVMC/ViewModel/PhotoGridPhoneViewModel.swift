import UIKit
import RxMVVMCShared

class PhotoGridPhoneViewModel: PhotoGridViewModel {
    
    
    // MARK: - Constants
    
    private enum Constants {
        static let minItemWidth: CGFloat = 80
    }
    
    
    // MARK: - Helper
    
    override func initialItemSize(for viewWidth: CGFloat) -> CGSize {
        return ItemSizeCalculator.calculateItemSize(viewWidth: viewWidth, minItemWidth: Constants.minItemWidth)
    }
}
