import UIKit

extension UIAlertController {
    
    static func showErrorAlert(message: String, presentedBy viewController: UIViewController, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = ViewCreator.createAlertView(title: "iPadApp", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: actionHandler))
            viewController.present(alertController, animated: true)
        }
    }
}
