//
//  AppDelegate.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 01.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Preferences.clearAll()
        Localization.initialize()
        SocketHandler.initialize()
        
        Thread.runOnBackgroundThread {
            SocketHandler.subscribeToAll()
        }
        
        if SocketHandler.isAuthorized() {
            window!.rootViewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
        }
        
        return true
    }

}
