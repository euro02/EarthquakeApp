//
//  Utils.swift
//  BurchardApp
//
//  Created by Eduardo Antonio Pérez Muñoz on 04/03/15.
//  Copyright (c) 2015 Charcoal Design. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    class func popUpMessage(message:NSString) {
        var alertView:UIAlertView = UIAlertView()
        alertView.title = "Information"
        alertView.message = message
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    
    class func getPrefs()-> NSUserDefaults{
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return prefs
    }
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
}
