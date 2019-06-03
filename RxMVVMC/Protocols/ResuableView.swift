import UIKit

protocol ReusableIdentifier: AnyObject {
    static var reusableString: String { get }
}

extension ReusableIdentifier {
    static var reusableString: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableIdentifier {}
