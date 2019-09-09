import Foundation
import XCGLogger


public let log: XCGLogger = {
    let log = XCGLogger()
    log.setup(level: .verbose)
    
    return log
}()
