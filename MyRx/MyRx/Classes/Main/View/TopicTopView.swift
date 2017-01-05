//
//  TopicTopView.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

class TopicTopView: UIView {

    @IBOutlet weak var namelabel: UILabel!

    @IBOutlet weak var leftBtn: UIButton!

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var memoLabel: UILabel!
    
    @IBOutlet weak var rightBtn: UIButton!

    override func awakeFromNib() {
        
    }
    
    
    var topic: Topic?{
        didSet{
            // 赋值
            guard  let tp = topic else { return }
            namelabel.text =  tp.info?.topic_name
            iconView.kf.setImage(with: URL(string: (tp.info?.avatar)!), placeholder: nil, options: nil, progressBlock: nil) { [weak self] (img, _, _, _) in
                self?.iconView.image = img?.kf.image(withRoundRadius: 50, fit: CGSize(width: 100, height: 100))
            }
            memoLabel.text = tp.info?.author
        }
    }
}
