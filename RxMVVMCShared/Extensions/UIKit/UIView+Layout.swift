import UIKit

public extension UIView {
    
    
    // MARK: - Helpers
    @discardableResult func centerHorizontally(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return centerXAnchor.constraint(equalTo: layoutElement.centerXAnchor, constant: offset).activate()
    }
    
    @discardableResult func centerVertically(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return centerYAnchor.constraint(equalTo: layoutElement.centerYAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinEdges(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        setConstraintTranslationToFalse()
        return [
            topEdge(to: layoutElement, withOffset: offset),
            bottomEdge(to: layoutElement, withOffset: -offset),
            leadingEdge(to: layoutElement, withOffset: offset),
            trailingEdge(to: layoutElement, withOffset: -offset)
        ]
    }
    
    @discardableResult func topEdge(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return topAnchor.constraint(equalTo: layoutElement.topAnchor, constant: offset).activate()
    }
    
    @discardableResult func bottomEdge(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return bottomAnchor.constraint(equalTo: layoutElement.bottomAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinLeadingAndTrailingEdges(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        setConstraintTranslationToFalse()
        return [
            leadingEdge(to: layoutElement, withOffset: offset),
            trailingEdge(to: layoutElement, withOffset: -offset)
        ]
    }
    
    @discardableResult func trailingEdge(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return trailingAnchor.constraint(equalTo: layoutElement.trailingAnchor, constant: offset).activate()
    }
    
    @discardableResult func leadingEdge(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return leadingAnchor.constraint(equalTo: layoutElement.leadingAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinTopEdgeToBottom(of layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return topAnchor.constraint(equalTo: layoutElement.bottomAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinBottomEdge(lessThanOrEqualTo layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return bottomAnchor.constraint(lessThanOrEqualTo: layoutElement.bottomAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinBottomEdgeToTop(of layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return bottomAnchor.constraint(equalTo: layoutElement.topAnchor, constant: offset).activate()
    }
    
    @discardableResult func pinTopAndBottomEdge(to layoutElement: LayoutAnchorable, withOffset offset: CGFloat = 0) -> [NSLayoutConstraint] {
        setConstraintTranslationToFalse()
        return [
            topEdge(to: layoutElement, withOffset: offset),
            bottomEdge(to: layoutElement, withOffset: -offset)
        ]
    }
    
    @discardableResult func pinSize(to size: CGSize) -> [NSLayoutConstraint] {
        setConstraintTranslationToFalse()
        return [
            pinWidth(to: size.width).activate(),
            pinHeight(to: size.height).activate()
        ]
    }
    
    @discardableResult func pinHeight(to height: CGFloat) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return heightAnchor.constraint(equalToConstant: height).activate()
    }
    
    @discardableResult func pinWidth(to width: CGFloat) -> NSLayoutConstraint {
        setConstraintTranslationToFalse()
        return widthAnchor.constraint(equalToConstant: width).activate()
    }
    
    private func setConstraintTranslationToFalse() {
        guard translatesAutoresizingMaskIntoConstraints else { return }
        translatesAutoresizingMaskIntoConstraints = false
    }
}

public protocol LayoutAnchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: LayoutAnchorable { }
extension UILayoutGuide: LayoutAnchorable { }
public extension NSLayoutConstraint {
    
    /// Activates the receiver and returns it.
    @discardableResult func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
