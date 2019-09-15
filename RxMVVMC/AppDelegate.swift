import UIKit
import RxMVVMCShared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    // MARK: - Properties
    // MARK: Mutable
    
    var window: UIWindow?
    private lazy var appCoordinator = AppCoordinator()
    
    
    // MARK: - Protocol Conformance
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarAppearance()
        appCoordinator.start()
        
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
