//
//  AppDelegate.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor(red: 195/255, green: 61/255, blue: 43/255, alpha: 1.0)
        return true
    }

    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return true
    }

}

