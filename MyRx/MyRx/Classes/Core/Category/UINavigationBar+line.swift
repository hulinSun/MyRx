//
//  UINavigationBar+line.swift
//  better
//
//  Created by Hony on 2016/11/11.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 去除黑线

extension UINavigationBar{
    
    class func getLine(view: UIView) -> UIImageView? {
        if view is UIImageView && (view.bounds.size.height <= 1.0) {
            return view as? UIImageView
        }
        
        for (_, subView) in view.subviews.enumerated(){
            guard let imgView = UINavigationBar.getLine(view: subView) else{
                return nil
            }
            return imgView
        }
        return nil
    }
}


