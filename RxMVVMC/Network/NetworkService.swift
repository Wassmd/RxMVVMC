import Foundation
import RxSwift

class NetworkService {
    
    typealias dict = [String: Any]
    
    private enum Constants {
        static let timeout: TimeInterval = 10.0
        static let apiKeyValue = "43753f3c6af7101d0078a6d016154662"
        static let method = "flickr.photos.search"
        static let searchText = "leopard"
        static let json = "json"
    }
    
    private enum RequestError: Error {
        case unknown
        case serverError
        case connectionFailed
        case invalidURL
        case invalidAPIKey
    }
    
    private enum ResponseError: Error {
        case malFunctionJson
        case noPhotosAvailable
    }
    
    private let config: URLSessionConfiguration
    
    init() {
        self.config = URLSessionConfiguration.default
        self.config.timeoutIntervalForRequest = Constants.timeout
        self.config.timeoutIntervalForResource = Constants.timeout
        self.config.waitsForConnectivity = true
    }
    
    func fetchPhotosRequest(isFallback: Bool = false) -> Single<[dict]> {
        guard let url = getURLString(isFallback) else {
            return Single.error(RequestError.invalidURL)
        }
        
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession(configuration: config)
        
        return Single.create { [weak self] subscriber -> Disposable in
            let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    subscriber(.error(error))
                } else if let data = data {
                    do {
                        print("Response form server: \(String(describing: String(data: data, encoding: .utf8)))")
                        if let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let networkError = self?.serverError(from: result) {
                                subscriber(.error(networkError))
                            } else {
                                if let photosDict = result["photos"] as? dict {
                                    guard let photos = photosDict["photo"] as? [dict]
                                        else { subscriber(.error(ResponseError.noPhotosAvailable)); return }
                                    subscriber(.success(photos))
                                }
                            }
                        }
                    } catch {
                        subscriber(.error(ResponseError.malFunctionJson))
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getURLString(_ isFallback: Bool) -> URL? {
        let flickerURL = flickerSearchURL()
        let localURL = Bundle.main.url(forResource: "kitten", withExtension: "json")
        
        return isFallback ? localURL : flickerURL
    }
    
    
    // MARK: - Helpers
    
    func flickerSearchURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest/"
        components.queryItems = [
            URLQueryItem(name: "method", value: Constants.method),
            URLQueryItem(name: "api_key", value: Constants.apiKeyValue),
            URLQueryItem(name: "text", value: Constants.searchText),
            URLQueryItem(name: "content_type", value: Constants.json),
            URLQueryItem(name: "format", value: Constants.json),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
        
        return components.url
    }
}


extension NetworkService {
    
    private func serverError(from result: [String:Any]) -> RequestError? {
        guard let status = result["stat"] as? String
            else { return .unknown}
        
        switch status {
        case "ok", "Ok", "OK":
            return nil
        case "fail":
            return .invalidAPIKey
        default:
            return .serverError
        }
    }
}
