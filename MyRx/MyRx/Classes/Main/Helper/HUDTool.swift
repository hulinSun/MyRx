//
//  HUDTool.swift
//  MyRx
//
//  Created by Hony on 2017/1/13.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit


class HUDTool: NSObject {
    
    /// 显示文字
    class func showText(message: String){
        HUD.flash(.label(message), delay: 2.0) { _ in
        }
    }
    
    /// 类似于sv的圈圈
    class func showProgress(){
       HUD.flash(.rotatingImage(UIImage(named: "progress")), delay: 2.0)
    }
    
    class func showSuccess(){
        HUD.flash(.success, delay: 2.0)
    }
    
    class func showError(){
        HUD.show(.error)
        HUD.hide(afterDelay: 2.0)
    }
    
    
}
