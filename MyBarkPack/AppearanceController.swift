//
//  AppearanceController.swift
//  MyBarkPack
//
//  Created by Diego Aguirre on 4/23/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class AppearanceController {
    static func initializeAppearanceDefaults() {
        UINavigationBar.appearance().barTintColor = UIColor.lightBlue()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}
