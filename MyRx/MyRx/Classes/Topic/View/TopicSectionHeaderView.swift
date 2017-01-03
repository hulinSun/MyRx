//
//  TopicSectionHeaderView.swift
//  MyRx
//
//  Created by Hony on 2017/1/3.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class TopicSectionHeaderView: UITableViewHeaderFooterView {

    enum TopicSectionHeadType: String {
        case hot, like, recommend, refresh
        
         var description: String{
            switch self {
            case .like:
                return "换一换"
            case .hot, .recommend , .refresh:
                return "更多"
            }
        }
    }
    
    /**
    Optional("topic_hot")
    Optional("topic_like")
    Optional("topic_recommend")
    Optional("topic_refresh")*/
    
    @IBOutlet weak var groupTypeButton: UIButton!
    @IBOutlet weak var topicTitleLabel: UILabel!{
        didSet{
            topicTitleLabel.textColor = UIColor("#7a7a7a")
        }
    }
    
    override func awakeFromNib() {
        contentView.backgroundColor = UIColor("#f7f7f7")
    }
    
    func config(group: TopicGroup) {
        topicTitleLabel.text = group.name
        let type = TopicSectionHeadType(rawValue: group.type!.subString(from: 6))
        groupTypeButton.setTitle(type?.description, for: .normal)
        
        if case .like? = type{
            groupTypeButton.setImage(UIImage(named: "topicRefresh"), for: .normal)
        }else{
            groupTypeButton.setImage(UIImage(named: "entityArrow"), for: .normal)
            groupTypeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
            groupTypeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        }
    }
}
