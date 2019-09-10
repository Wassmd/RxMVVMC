import Foundation
import RxMVVMCShared
import RxSwift
import RxCocoa

class PhotoDownloadServiceMock: PhotoDownloadServiceProtocol {
    
    
    // MARK: Inner Types
    
    let calledCount = CalledCount()
    var returnValue = ReturnValue()
    
    struct CalledCount {
        
    }
    
    struct ReturnValue {
        var photosSingle: Single<[Photo]> = Single.just([])
    }
    
    func downloadPhotos(with searchText: String) -> Single<[Photo]> {
        return returnValue.photosSingle
    }
}
