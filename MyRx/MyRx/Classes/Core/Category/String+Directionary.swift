//
//  String+Directionary.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation


extension String{
    
    /// 返回document文件下的文件路径
    func documentFileData() -> String {
        
        let doc = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString
        return doc.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    
    /// 返回偏好设置文件下的文件路径
    func preferenceFileData() -> String {
        
        let doc = NSSearchPathForDirectoriesInDomains(.preferencePanesDirectory, .userDomainMask, true).last! as NSString
        return doc.appendingPathComponent((self as NSString).lastPathComponent)
    }
    
    
    /// 返回cache文件下的文件路径
    func cacheFileData() -> String {
        
        let doc = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last! as NSString
        return doc.appendingPathComponent((self as NSString).lastPathComponent)
    }
}
