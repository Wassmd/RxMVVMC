import Foundation

typealias ErrorMessage = String

extension Error {
    var parseErrorMessge: ErrorMessage {
        if let errorMessage = (self as NSError).userInfo["NSLocalizedDescription"] as? String {
            return errorMessage
        } else {
            return "Error occurred"
        }
    }
}
