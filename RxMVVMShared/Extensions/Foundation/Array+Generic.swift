import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        if index >= 0 && index < count {
            return self[index]
        }
        
        return nil
    }
}
