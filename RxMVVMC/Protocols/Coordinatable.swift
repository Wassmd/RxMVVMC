import Foundation

public protocol CoordinateTo {}

public protocol CoordinatorDeallocatable: AnyObject {
    var childCoordinators: [UUID: Coordinatable] { get set }
    
    func deallocate(with identifier: UUID)
}

public protocol CoordinatorPresentable: AnyObject {
    var uniqueId: UUID { get }
    var deallocatable: CoordinatorDeallocatable? { get }
    
    func coordinate(to step: CoordinateTo)
    func start()
    func dispose()
}


public protocol Coordinatable: CoordinatorPresentable, CoordinatorDeallocatable {}

public extension CoordinatorPresentable {
    func dispose() {
        deallocatable?.deallocate(with: uniqueId)
    }
}

public extension CoordinatorDeallocatable {
    func deallocate(with uniqueId: UUID) {
        childCoordinators[uniqueId] = nil
    }
}
