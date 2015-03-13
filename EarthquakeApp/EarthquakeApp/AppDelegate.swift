//
//  AppDelegate.swift
//  EarthquakeApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 11/03/15.
//  Copyright (c) 2015 Eduardo Perez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.statusBarStyle = .LightContent
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "navigation"), forBarMetrics: .Default)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        return true
    }

}

