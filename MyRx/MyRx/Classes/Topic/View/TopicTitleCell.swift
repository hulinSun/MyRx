//
//  TopicTitleCell.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class TopicTitleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var topicMemoLabel: UILabel!
    @IBOutlet weak var topicTitleLale: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
