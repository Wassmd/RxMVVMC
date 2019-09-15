import UIKit

open class BaseAppDelegate: UIResponder, UIApplicationDelegate {
    
    
    // MARK: - Properties
    // MARK: Mutable
    
    public var window: UIWindow?
    
    // MARK: - Protocol Conformance
    // MARK: UIApplicationDelegate
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavigationBarAppearance()

        
        return true
    }
    
    // MARK: - Helper
    
    private func setupNavigationBarAppearance() {
        let navigationbar = UINavigationBar.appearance()
        navigationbar.tintColor = .tintColor
        navigationbar.barTintColor = .navigationBarColor
        navigationbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationbar.barStyle = .black
    }
}
