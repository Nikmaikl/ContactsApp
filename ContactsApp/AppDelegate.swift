//
//  AppDelegate.swift
//  ContactsApp
//
//  Created by Michael Nikolaev on 05.01.2018.
//  Copyright © 2018 Michael Nikolaev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ContactsViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
