//
//  Appdelegate+Extension.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

extension AppDelegate{
    
    func configWindow()  {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = MainTabbarController()
//        self.window?.rootViewController = ViewController()
    }
}

