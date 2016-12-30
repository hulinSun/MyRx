//
//  String+Extension.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation


extension String {
    
    func subString(to idx: Int) -> String {
        return substring(to: index(startIndex, offsetBy: idx))
    }
    
    func subString(from idx: Int) -> String {
        return substring(from: index(startIndex, offsetBy: idx))
    }
    
    func subString(withStart start: Int, end: Int) -> String {
        let range = Range<Index>.init(uncheckedBounds: (lower: index(startIndex, offsetBy: start), upper: index(startIndex, offsetBy: end)))
        return substring(with: range)
    }
    
    static func uuid() -> String {
        let uuidRef = CFUUIDCreate(nil)
        let uuidStr = CFUUIDCreateString(nil, uuidRef)
        let uuid: String = uuidStr as! String
        return uuid
    }
}

