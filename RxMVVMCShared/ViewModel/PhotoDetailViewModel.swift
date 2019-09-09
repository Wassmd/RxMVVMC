import Foundation

public class PhotoDetailViewModel {
    
    
    // MARK: - Properties
    // MARK: Immutables
    
    public let currenIndexPath: IndexPath
    public var photos = [Photo]()
    
    
    // MARK: - Initializer
    
    public init(with indexPath: IndexPath, photos: [Photo]) {
        self.currenIndexPath = indexPath
        self.photos = photos
    }
    
    
    // MARK: - Helper
    
    public func photo(at indexPath: IndexPath) -> Photo? {
        return photos[safe: indexPath.row]
    }
}
