import Foundation

public struct PhotosDetail: Decodable {
    let photos: Photos
    let stat: String
}

public struct Photos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

public struct Photo: Decodable {
    public let id: String
    public let owner: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let title: String?
}

extension Photo {
    public var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
