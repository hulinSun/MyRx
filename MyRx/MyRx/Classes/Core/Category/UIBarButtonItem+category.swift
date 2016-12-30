//
//  UIBarButtonItem+category.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import ManualLayout


extension UIBarButtonItem{
    
    /// 文字item
    ///
    /// - parameter title:          文字
    /// - parameter color:          普通状态下颜色
    /// - parameter highLightColor: 高亮颜色
    /// - parameter target:         传递的target
    /// - parameter action:         selector
    ///
    class func itemWith(title: String , color: UIColor , highLightColor: UIColor ,target:AnyObject? ,action: Selector)-> UIBarButtonItem{
        let btn = UIButton()
        btn.bounds.size = CGSize(width: 40, height: 20)
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(highLightColor, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.sizeToFit()
        return UIBarButtonItem.init(customView: btn)
    }
    
    /**
     图片item
     
     - parameter icon:          普通状态下的图片
     - parameter highlightIcon: 高亮状态下的图片
     - parameter target:        传递的target
     - parameter action:        传递的selector
     
     */
    class func itemWith(icon: String , highlightIcon: String ,target: AnyObject? ,action: Selector)-> UIBarButtonItem{
        
        let btn = UIButton()
        btn.bounds.size = CGSize(width: 30, height: 30)
        btn.setImage(UIImage(named: icon), for: .normal)
        btn.setImage(UIImage(named: highlightIcon), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    
    class func itemWithBack(icon: String , highlightIcon: String ,target: AnyObject? ,action: Selector)-> UIBarButtonItem{
        
        let btn = UIButton()
        btn.bounds.size = CGSize(width: 15, height: 18)
        btn.setBackgroundImage(UIImage(named: icon), for: .normal)
        btn.setBackgroundImage(UIImage(named: highlightIcon), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: btn)
    }

    convenience init(imageName:String, target: AnyObject?, action: String?){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named:imageName), for: .highlighted)
        if action != nil{
            btn.addTarget(target, action: Selector(action!), for: .touchUpInside)
        }
        btn.width = 27; btn.height = 27;
        self.init(customView: btn)
    }
}
