//
//  UIColor+random.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func random() -> UIColor{
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let colorRun = UIColor(red:red, green:green, blue:blue , alpha: 1)
        return colorRun
    }
    
}
