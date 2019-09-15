import XCTest
import Nimble
@testable import RxMVVMC_iPad

class PhotoGridPadViewModelTests: XCTestCase {
    
    private var viewModel: PhotoGridPadViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = PhotoGridPadViewModel()
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
        let expectedSize = CGSize(width: 350.0, height: 350.0)
        
        expect(size).to(equal(expectedSize))
    }
}
