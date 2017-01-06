
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lay.position = CGPoint(x: 0, y: 49.3)
        self.layer.addSublayer(lay)
    }
    
    fileprivate lazy var lay: CALayer = {
        let i = CALayer()
        i.backgroundColor = UIColor("#e3e3e5").cgColor
        i.anchorPoint = CGPoint.zero
        i.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 0.7)
        return i
    }()
    
    var topic: Topic?{
        didSet{

//            created	String 13:05:47
            timeLabel.text = topic?.info?.created?.subString(from: 11).subString(to: 5)
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
