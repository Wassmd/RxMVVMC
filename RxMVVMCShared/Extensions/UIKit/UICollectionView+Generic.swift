import UIKit

public extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reusableString)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reusableString, for: indexPath) as? T
        return cell.require()
    }
}
