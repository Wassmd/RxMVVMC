import UIKit
import RxSwift
import RxCocoa

final class PhotoGridViewModel {
    
    
    // MARK: - Constants
    
    private enum Constants {
        static let minItemWidth: CGFloat = 200
    }
    
    //MARK: Properties
    //MARK: Immutables
    
    private let networkService: NetworkService
    private let disposeBag = DisposeBag()
    private let photosRelay = BehaviorRelay<[Photo]>(value: [])
    private let errorRelay = PublishRelay<Error>()
    
    var photosRelayObserver: Observable<[Photo]> {
        return photosRelay.asObservable()
    }
    var errorRelayObserver: Observable<Error> {
        return errorRelay.asObservable()
    }
    
    
    // MARK: Mutable
    
    var scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
    
    
    //MARK: - Initializers
    
    init(networkService:NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    
    //MARK: Action
    
    func downloadPhotos(isFallBack: Bool = false) {
        networkService.fetchPhotosRequest(isFallback: isFallBack)
            .subscribeOn(scheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                guard let self = self else { return }
                self.photosRelay.accept(self.photo(from: $0))
                }, onError: { [weak self] in self?.handleError(error: $0) })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Helper
    
    func initialItemSize(for viewWidth: CGFloat) -> CGSize {
        guard viewWidth > 0 else { return CGSize.zero}
        
        let overallItemSize = Constants.minItemWidth + LayoutConstants.defaultPadding
        let numberofItemsPerRow = Int(viewWidth / overallItemSize)
        let paddingSum = CGFloat(numberofItemsPerRow + 1) * LayoutConstants.defaultPadding
        let itemWidth = (viewWidth - paddingSum) / CGFloat(numberofItemsPerRow)
        
        return CGSize(square: itemWidth)
    }
    
    
    // MARK: - Datasource
    
    func numberOfPhotos(at section: Int) -> Int {
        return photosRelay.value.count
    }
    
    func photoObject(at indexPath: IndexPath) -> Photo? {
        return photosRelay.value[safe: indexPath.item]
    }
    
    
    //MARK: - Helpers
    
    func photo(from dictArray: [[String: Any]]) -> [Photo] {
        return dictArray.map { Photo.photoObject(dict: $0) }
    }
    
    func handleError(error: Error) {
        errorRelay.accept(error)
    }
}
