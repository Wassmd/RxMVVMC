import Foundation
import RxCocoa
import RxSwift

extension ObservableType where Element: OptionalType {
    func filterNotNil() -> Observable<Element.Wrapped> {
        return filter { $0.asOptional != nil }.map { $0.asOptional! }
    }
}
