import Foundation

struct PhotosDetail: Decodable {
    let photos: Photos
    let stat: String
}

struct Photos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photo]
}

struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String?
}

extension Photo {
    var photoUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
