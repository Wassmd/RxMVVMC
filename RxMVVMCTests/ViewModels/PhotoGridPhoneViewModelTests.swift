import XCTest
import Nimble
@testable import RxMVVMC

class PhotoGridPhoneViewModelTests: XCTestCase {
    
    private var viewModel: PhotoGridPhoneViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = PhotoGridPhoneViewModel()
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
        let size = viewModel.initialItemSize(for: 375)
        let expectedSize = CGSize(squareLength: 139.5)
        
        expect(size).to(equal(expectedSize))
    }
}
