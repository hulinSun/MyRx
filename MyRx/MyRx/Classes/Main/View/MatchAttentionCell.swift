//
//  MatchAttentionCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import RxSwift
import RxCocoa

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

 extension Reactive where Base: MatchAttentionCell {
    var topic: UIBindingObserver<Base, Topic> {
        return UIBindingObserver(UIElement: base) { cell, topic in
            guard topic.type == "tl" else { return }
            cell.topicTitleLabel.setTitleColor(UIConst.themeColor, for: .normal)
            cell.topicTitleLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            cell.topicTitleLabel.setTitle(topic.topicinfo?.topic_name, for: .normal)
            cell.memoLabel.text = topic.topicinfo?.intro ?? "这个话题很美哦"
            cell.creatLabel.text = (topic.topicinfo?.user_name)! + " 创建"
            cell.timeLabel.text = topic.topicinfo?.created ?? "时间未知"
            cell.creatLabel.textColor = UIColor("#576972")
            cell.creatLabel.font = UIFont.systemFont(ofSize: 12)
            cell.timeLabel.textColor =  UIColor("#576972")
            if let follow = topic.topicinfo?.is_follow , follow{
                cell.plusBtn.setTitle("已关注", for: .normal)
                cell.plusBtn.setImage(nil, for: .normal)
            }else{
                cell.plusBtn.setTitle(nil, for: .normal)
                cell.plusBtn.setImage(UIImage(named: "careList_care"), for: .normal)
            }
            if let count = topic.users?.count, (Int(count))! > 0{
                cell.topLabel.text = "有\(count)个好友关注了"
            }
        }
    }
}
