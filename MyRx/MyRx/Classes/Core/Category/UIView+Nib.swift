//
//  UIView+Nib.swift
//  better
//
//  Created by Hony on 2016/11/25.
//  Copyright © 2016年 Hony. A

import UIKit


public protocol UIViewLoading {}

extension UIView : UIViewLoading {}

public extension UIViewLoading where Self : UIView {
    static func loadFromNib() -> Self {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).filter { $0 is Self }.last as! Self
        // return nib.instantiate(withOwner: self, options: nil).last as! Self
    }
}



