//
//  AppDelegate.swift
//  Trayning
//
//  Created by yoshihiko on 2015/11/11.
//  Copyright © 2015年 goodmix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //user defaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey("point0Sensivity") == nil {
            userDefaults.setFloat(0.0, forKey: "point0Sensivity")
        }
        if userDefaults.objectForKey("point1Sensivity") == nil {
            userDefaults.setFloat(0.0, forKey: "point1Sensivity")
        }
        if userDefaults.objectForKey("point2Sensivity") == nil {
            userDefaults.setFloat(0.0, forKey: "point2Sensivity")
        }
        
        if userDefaults.objectForKey("pointInterval") == nil {
            userDefaults.setInteger(60, forKey: "pointInterval")
        }
        
        if userDefaults.objectForKey("noEatInterval") == nil {
            userDefaults.setInteger(60, forKey: "noEatInterval")
        }
        
        //TrayController
        TrayController.shared.ready()
        TrayController.shared.connect()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

