//import UIKit
//
//private enum HTTPMethod: String {
//    case GET
//    case POST
//    case PUT
//    case DELETE
//}
//
//private enum RequestError: Error {
//    case unknown
//    case networkError
//    case invalidURL
//}
//
//private enum LoaderConstants {
//     enum Headers {
//        static let contentTypeHeader = "Content-Type"
//    }
//    
//    enum HeaderValues {
//        static let contentTypeHeaderJsonValue = "application/json"
//    }
//}
//
//protocol LoaderProtocol {
//    func load(_ url: URL, ignoreCache: Bool, json: JSON?, timeoutInterval: TimeInterval, completionHandler: @escaping (Result<Data, Error>) -> Void)
//    func post(_ url: URL, body: Data?, headers: HTTPHeaders?, completionHandler: @escaping (Result<Data, Error>) -> Void)
//    func put(_ url: URL, body: Data?, completionHandler: @escaping (Result<Data, Error>) -> Void)
//    func delete(_ url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
//}
//
//typealias JSON = [String: Any]
//typealias HTTPHeaders = [String: String]
//
//class Loader: LoaderProtocol {
//
//
//    // MARK: - Inner Types
//    
//    private enum Constants {
//        static let defaultTimeout: TimeInterval = 5.0
//    }
//    
//    // MARK: - Properties
//    // MARK: Immutable
//    
//    private let urlSession: URLSession
//    
//    // MARK: - initializer
//    
//    init(urlSession: URLSession = URLSession(configuration: .default)) {
//        self.urlSession = urlSession
//    }
//    
//    
//    // MARK: - setup
//    
//    private func requestObject(
//        withUrl url: URL,
//        httpMethod: HTTPMethod = .GET,
//        headers: HTTPHeaders? = nil,
//        ignoreCache: Bool = false,
//        parameter: JSON? = nil,
//        jsonBodyData: Data? = nil,
//        timeoutInterval: TimeInterval = Constants.defaultTimeout) -> URLRequest {
//        
//        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
//        
//        if httpMethod == .GET, let parameter = parameter, parameter.keys.count > 0 {
//            var items = [URLQueryItem]()
//            parameter.forEach { items.append(URLQueryItem(name: $0.key, value: $0.value as? String)) }
//            
//            urlComponents.queryItems = items
//        }
//        
//        var request = URLRequest(url: urlComponents.url!, cachePolicy: ignoreCache ? .reloadIgnoringLocalCacheData : .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
//        
//        request.httpMethod =  httpMethod.rawValue
//        request.addValue(LoaderConstants.HeaderValues.contentTypeHeaderJsonValue, forHTTPHeaderField: LoaderConstants.Headers.contentTypeHeader)
//        
//        request.httpBody = jsonBodyData
//        
//        print("request: \(String(describing: request.url?.absoluteURL))")
//        print("request.httpBody: \(String(describing: String(data: jsonBodyData ?? Data(), encoding: .utf8)))")
//        return request
//    }
//    
//    
//    // MARK: - Protocol conformance
//    
//    func load(_ url: URL, ignoreCache: Bool, json: JSON?, timeoutInterval: TimeInterval, completionHandler: @escaping (Result<Data, Error>) -> Void) {
//        let request = requestObject(withUrl: url, parameter: json)
//        execute(request, completionHandler)
//    }
//
//    func post(_ url: URL, body: Data? = nil, headers: HTTPHeaders? = nil, completionHandler: @escaping (Result<Data, Error>) -> Void) {
//        let urlRequest = requestObject(withUrl: url, httpMethod: .POST, jsonBodyData: body)
//        return execute(urlRequest, completionHandler)
//    }
//    
//   func put(_ url: URL, body: Data? = nil, completionHandler: @escaping (Result<Data, Error>) -> Void) {
//        let urlRequest = requestObject(withUrl: url, httpMethod: .PUT, jsonBodyData: body)
//        return execute(urlRequest, completionHandler)
//    }
//    
//    func delete(_ url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
//        let urlRequest = requestObject(withUrl: url, httpMethod: .DELETE)
//        return execute(urlRequest, completionHandler)
//    }
//    
//    
//    // MARK: - Request execution
//    
//    private func execute(_ urlRequest: URLRequest, _ completionHandler: @escaping (Result<Data, Error>) -> Void) {
//        let task = urlSession.dataTask(with: urlRequest) { (data, _, error) in
//            guard error == nil else {
//                print("error:\(String(describing: error))")
//                completionHandler(.failure(error!))
//                return
//            }
//            
//            if let data = data {
//                completionHandler(.success(data))
//            }
//        }
//        task.resume()
//    }
//}
