import UIKit
import RxMVVMCShared

class PhotoGridPhoneCell: PhotoGridCell {
    private enum Constants {
        static let titleLabelFont = UIFont.boldSystemFont(ofSize: 15)
    }
    
    override func setupSubViews() {
        super.setupSubViews()
        titleLabel.font = Constants.titleLabelFont
    }
}
