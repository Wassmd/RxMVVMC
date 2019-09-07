import UIKit

public enum ViewCreator {
    
    // MARK: - Properties
    // MARK: Constants
    
    public enum Constants {
        public static let iconBorderWidth: CGFloat = 7
        public static let cornerRadius: CGFloat = 4
    }
    
    
    // MARK: - Helpers
    
    public static func createImageContaionerWithBoarder(
        borderColor: UIColor = .gray,
        borderWidth: CGFloat = Constants.iconBorderWidth,
        cornerRadius: CGFloat = Constants.cornerRadius,
        backgroudColor: UIColor = .clear) -> UIView {
        let view = UIView()
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = backgroudColor
        
        return view
    }
    
    public static func createAlertView(title: String?, message: String?, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.view.tintColor = .black
        
        return alertController
    }
}
