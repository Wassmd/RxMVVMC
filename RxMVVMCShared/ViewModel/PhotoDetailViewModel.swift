import Foundation

public class PhotoDetailViewModel {
    
    // MARK: - Properties
    // MARK: Immutables
    
    public let currentPhoto: Photo
    public var photos = [Photo]()
    
     // MARK: - Initializer
    
    public init(with currentPhoto: Photo, photos: [Photo]) {
        self.currentPhoto = currentPhoto
        self.photos = photos
    }
}
