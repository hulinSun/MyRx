
//
//  TopicBottomView.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class TopicBottomView: UIView {

    @IBOutlet weak var zanBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var topic: Topic?{
        didSet{
            // 赋值
//            created	String	2017-01-06 13:05:47
            timeLabel.text = topic?.info?.created?.subString(from: 11)
            
            if let heart = topic?.info?.heart, Int(heart)! > 0{
                zanBtn.setTitle(heart, for: .normal)
            }else{
                zanBtn.setTitle("", for: .normal)
            }
            
            if let comment = topic?.info?.comment, Int(comment)! > 0{
                commentBtn.setTitle(comment, for: .normal)
            }else{
                commentBtn.setTitle("", for: .normal)
            }
            if let forward = topic?.info?.forward, Int(forward)! > 0{
                forwardBtn.setTitle(forward, for: .normal)
            }else{
                forwardBtn.setTitle("", for: .normal)
            }
            
        }
    }
}
