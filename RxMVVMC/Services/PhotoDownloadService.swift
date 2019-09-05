import Foundation
import RxSwift
import EndPointLoader

protocol PhotoDownloadServiceProtocol {
    func downloadPhotos(with searchText: String) -> Single<[Photo]>
}

final class PhotoDownloadService: PhotoDownloadServiceProtocol {
    
    private let loader: Loader
    private let jsonDecoder: JSONDecoder
    
    init(loader: Loader = Loader(),
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.loader = loader
        self.jsonDecoder = jsonDecoder
    }
    
    func downloadPhotos(with searchText: String) -> Single<[Photo]> {
        var urlQuery = URL.prepareFixedMetaDataForURLComponent
        urlQuery["text"] = searchText
        
        return Single.create { [weak self] observer in
            guard let self = self else { return  Disposables.create() }
            
            self.loader.load(URL.baseEndpoint, ignoreCache: true, json: urlQuery, timeoutInterval: 5.0) { result in
                switch result {
                case .success(let data):
                    print("\(String(describing: String(data: data, encoding: .utf8)))")
                    do {
                        let photoDetail = try self.jsonDecoder.decode(PhotosDetail.self, from: data)
                        print("something........\(photoDetail.stat)")
                        observer(.success(photoDetail.photos.photo))
                    } catch {
                        print("error why creating models:\(error)")
                        observer(.error(error))
                    }
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create()
        }
    }
}
