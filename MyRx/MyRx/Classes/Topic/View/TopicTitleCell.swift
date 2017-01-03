//
//  TopicTitleCell.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import ReusableKit


class TopicTitleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var topicMemoLabel: UILabel!
    @IBOutlet weak var topicTitleLale: UILabel!{
        didSet{
            topicTitleLale.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 35
        }
    }
    
    func config(_ model: TopicInfo) {
        
        topicTitleLale.text = model.topic_name ?? "😝"
        var typeStr = ""
        guard  let type = model.topic_type else {
            topicMemoLabel.text = model.view! + "次浏览"
            return
        }
        if type == "imagetext" {
            iconView.isHidden = true
        }else if type == "image"{
            typeStr = " · 图片话题"
            iconView.isHidden = false
            iconView.image = UIImage(named: "createTopic_photo")
        }else if type == "voice"{
            typeStr = " · 语音话题"
            iconView.isHidden = false
            iconView.image = UIImage(named: "createTopic_voice")
        }
        topicMemoLabel.text = model.view! + "次浏览" + typeStr
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
