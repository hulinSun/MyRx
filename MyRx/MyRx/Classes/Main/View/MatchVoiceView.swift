//
//  MatchVoiceView.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class MatchVoiceView: UIView {
    
    @IBOutlet weak var realView: UIView!{
        didSet{
            realView.layer.cornerRadius = 4
            realView.clipsToBounds = true
        }
    }

    @IBOutlet weak var iconView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 10
        let padding: CGFloat = 13
        realView.frame = CGRect(x: padding, y: margin, width: UIConst.screenWidth - 2 * padding, height: 120)
        iconView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
    }
}
