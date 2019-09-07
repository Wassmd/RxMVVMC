import UIKit

public protocol ReusableIdentifier: AnyObject {
    static var reusableString: String { get }
}

public extension ReusableIdentifier {
    static var reusableString: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableIdentifier {}
