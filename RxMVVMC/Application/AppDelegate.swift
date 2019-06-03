//
//  AppDelegate.swift
//  IPad_App
//
//  Created by Mohammed Wasimuddin on 31.05.19.
//  Copyright © 2019 Demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    // MARK: Mutable
    
    var window: UIWindow?
    private lazy var appCoordinator = AppCoordinator()
    
    // MARK: - Protocol Conformance
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator.start()
        return true
    }
}

