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
            topicTitleLale.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 55
        }
    }
    
    func config(_ model: TopicInfo) {
        topicTitleLale.text = model.topic_name ?? "😝"
        topicMemoLabel.text = model.view ?? "😝"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
