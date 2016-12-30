//
//  JSONTool.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit



class JSONTool: NSObject {
    
    class func dataWith(name: String) -> Data{
        let s = Bundle.main.path(forResource: name, ofType: nil)
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: s!))else{
            return Data()
        }
        return data
    }

}
