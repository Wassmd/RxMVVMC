import UIKit
import RxSwift
import RxCocoa

public final class PhotoGridViewModel {
    
    
    // MARK: - Constants
    
    private enum Constants {
        static let minItemWidth: CGFloat = 200
    }
    
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
    
    var scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
    
    
    // MARK: - Initializers
    
    public init(downloadService: PhotoDownloadServiceProtocol = PhotoDownloadService()) {
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
    
    public func initialItemSize(for viewWidth: CGFloat) -> CGSize {
        guard viewWidth > 0 else { return CGSize.zero }
        
        let overallItemSize = Constants.minItemWidth + LayoutConstants.defaultPadding
        let numberofItemsPerRow = Int(viewWidth / overallItemSize)
        let paddingSum = CGFloat(numberofItemsPerRow + 1) * LayoutConstants.defaultPadding
        let itemWidth = (viewWidth - paddingSum) / CGFloat(numberofItemsPerRow)
        
        return CGSize(squareLength: itemWidth)
    }
}
