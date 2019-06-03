import Foundation

struct Photo: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String?
    
    var imageUrl: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
}

extension Photo {
    static func photoObject(dict: [String: Any]) -> Photo {
        let id = dict["id"] as! String
        let owner = dict["owner"] as! String
        let secret = dict["secret"] as! String
        let server = dict["server"] as! String
        let farm = dict["farm"] as! Int
        let title = dict["title"] as? String ?? "Kitten"
        return Photo(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
    }
}
