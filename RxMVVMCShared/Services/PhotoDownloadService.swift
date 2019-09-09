import Foundation
import RxSwift
import EndPointLoader

public protocol PhotoDownloadServiceProtocol {
    func downloadPhotos(with searchText: String) -> Single<[Photo]>
}

public final class PhotoDownloadService: PhotoDownloadServiceProtocol {
    
    private let loader: Loader
    private let jsonDecoder: JSONDecoder
    
    public init(loader: Loader = Loader(),
         jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.loader = loader
        self.jsonDecoder = jsonDecoder
    }
    
    public func downloadPhotos(with searchText: String) -> Single<[Photo]> {
        var urlQuery = URL.prepareFixedMetaDataForURLComponent
        urlQuery["text"] = searchText
        
        return Single.create { [weak self] observer in
            guard let self = self else { return  Disposables.create() }
            
            self.loader.get(URL.baseEndpoint, ignoreCache: true, json: urlQuery, timeoutInterval: 5.0) { result in
                switch result {
                case .success(let data):
                    do {
                        let photoDetail = try self.jsonDecoder.decode(PhotosDetail.self, from: data)
                        log.debug("status: \(photoDetail.stat)")
                        observer(.success(photoDetail.photos.photo))
                    } catch {
                        log.debug("error while creating models:\(error)")
                        observer(.error(error))
                    }
                case .failure(let error):
                    log.debug(error)
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
