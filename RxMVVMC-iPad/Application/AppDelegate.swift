import UIKit
import RxMVVMCShared

@UIApplicationMain
class AppDelegate: BaseAppDelegate {

    
    // MARK: - Properties
    // MARK: Mutable
    
    private lazy var appCoordinator = AppCoordinator()
    
   
    // MARK: - Protocol Conformance
    // MARK: UIApplicationDelegate
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
