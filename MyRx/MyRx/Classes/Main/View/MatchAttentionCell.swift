//
//  MatchAttentionCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class MatchAttentionCell: UITableViewCell {

    @IBOutlet weak var topicTitleLabel: UIButton!
    
    @IBOutlet weak var topLabel: UILabel!{
        didSet{
            topLabel.textColor = UIColor("#576972")
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var creatLabel: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var topic: Topic?{
        didSet{
            // 赋值
            guard topic?.type == "tl" else { return }
            topicTitleLabel.setTitleColor(UIConst.themeColor, for: .normal)
            topicTitleLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            topicTitleLabel.setTitle(topic?.topicinfo?.topic_name, for: .normal)
            memoLabel.text = topic?.topicinfo?.intro ?? "这个话题很美哦"
            creatLabel.text = (topic?.topicinfo?.user_name)! + " 创建"
            timeLabel.text = topic?.topicinfo?.created ?? "时间未知"
            creatLabel.textColor = UIColor("#576972")
            creatLabel.font = UIFont.systemFont(ofSize: 12)
            timeLabel.textColor =  UIColor("#576972")
            if let follow = topic?.topicinfo?.is_follow , follow{
                plusBtn.setTitle("已关注", for: .normal)
                plusBtn.setImage(nil, for: .normal)
            }else{
                plusBtn.setTitle(nil, for: .normal)
                plusBtn.setImage(UIImage(named: "careList_care"), for: .normal)
            }
            if let count = topic?.users?.count, (Int(count))! > 0{
                topLabel.text = "有\(count)个好友关注了"
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        lay.position = CGPoint(x: 0, y: 143)
        self.layer.addSublayer(lay)
    }
    
    fileprivate lazy var lay: CALayer = {
        let i = CALayer()
        i.backgroundColor = UIColor("#e3e3e5").cgColor
        i.anchorPoint = CGPoint.zero
        i.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 0.6)
        return i
    }()
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
