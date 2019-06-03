import Foundation

protocol OptionalType {
    associatedtype Wrapped
    var asOptional: Wrapped? { get }
}

extension Optional: OptionalType {
    var asOptional: Wrapped? { return self }
}
