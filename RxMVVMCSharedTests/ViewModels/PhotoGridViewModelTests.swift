import XCTest
import Nimble
import RxSwift
import RxTest
@testable import RxMVVMCShared

class PhotoGridViewModelTests: XCTestCase {
    
    private var viewModel: PhotoGridViewModel!
    private var photoDownloadService: PhotoDownloadServiceMock!
    private var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        photoDownloadService = PhotoDownloadServiceMock()
        viewModel = PhotoGridViewModel(downloadService: photoDownloadService)
    }
    
    func testDownloadPhotos() {
        let photo1 = Photo(id: "1", owner: "someOwner1", secret: "someSecret1", server: "someServer1", farm: 11, title: "someTitle1")
        let photo2 = Photo(id: "2", owner: "someOwner2", secret: "someSecret2", server: "someServer2", farm: 22, title: "someTitle2")
        let photo3 = Photo(id: "3", owner: "someOwner3", secret: "someSecret3", server: "someServer3", farm: 33, title: "someTitle33")
        
        let observable = viewModel.photosRelayObserver
        let observer = scheduler.createObserver([Photo].self)
        let disposeBag = DisposeBag()
        
        scheduler.scheduleAt(0) {
            disposeBag.insert([
                observable.subscribe(observer)
                ])
        }
        photoDownloadService.returnValue.photosSingle = Single.just([photo1, photo2, photo3])
        
        scheduler.start()
        viewModel.downloadPhotos(searchString: "Cars")
        
        let photos = observer.events.first?.value.element
        expect(photos?.count).to(equal(3))
    }
    
    func testInitialItemSize_negativeInput_zeroReturned() {
        let size = viewModel.initialItemSize(for: -10)
        
        expect(size).to(equal(CGSize.zero))
    }
    
    func testInitialItemSize_zeroInput_zeroReturned() {
        let size = viewModel.initialItemSize(for: 0)
        
        expect(size).to(equal(CGSize.zero))
    }
    
    func testInitialItemSize_largePhoneWidth_correctSizeReturned() {
        let size = viewModel.initialItemSize(for: 414)
        let expectedSize = CGSize(squareLength: 350.0)
        
        expect(size).to(equal(expectedSize))
    }
}
