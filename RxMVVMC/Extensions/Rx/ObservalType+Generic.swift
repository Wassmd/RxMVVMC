import Foundation
import RxCocoa
import RxSwift

extension ObservableType where E: OptionalType {
    func filterNotNil() -> Observable<E.Wrapped> {
        return filter { $0.asOptional != nil }.map { $0.asOptional! }
    }
}
