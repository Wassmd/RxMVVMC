import UIKit
import RxSwift
import RxCocoa

open class PhotoGridViewModel {
    
    
    // MARK: - Properties
    // MARK: Immutables
    
    private let disposeBag = DisposeBag()
    private let photosRelay = BehaviorRelay<[Photo]>(value: [])
    private let errorRelay = PublishRelay<String>()
    
    private let downloadService: PhotoDownloadServiceProtocol
    
    public var photosRelayObserver: Observable<[Photo]> {
        return photosRelay.skip(1).asObservable()
    }
    public var errorRelayObserver: Observable<String> {
        return errorRelay.asObservable()
    }
    
    
    // MARK: Mutable
    
    var scheduler: SchedulerType
    
    
    // MARK: - Initializers
    
    public init(with scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background), downloadService: PhotoDownloadServiceProtocol = PhotoDownloadService()) {
        self.scheduler = scheduler
        self.downloadService = downloadService
    }
    
    
    // MARK: Action
    
    public func downloadPhotos(searchString: String, isFallBack: Bool = false) {
        downloadService.downloadPhotos(with: searchString)
            .subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                guard let self = self else { return }
                self.photosRelay.accept($0)

                }, onError: { [weak self] in

                    self?.handleError(error: $0)
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Datasource
    
    public func numberOfPhotos(at section: Int) -> Int {
        return photosRelay.value.count
    }
    
    public func photoObject(at indexPath: IndexPath) -> Photo? {
        return photosRelay.value[safe: indexPath.item]
    }
    
    public var allPhoto: [Photo] {
        return photosRelay.value
    }
    
    
    // MARK: - Helpers
    
    func handleError(error: Error) {
        errorRelay.accept(error.localizedDescription)
    }
    
    open func initialItemSize(for viewWidth: CGFloat) -> CGSize {
        fatalError("Must be implemented by subclass")
    }
}
