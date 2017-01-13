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

    @IBOutlet weak var namelabel: UILabel!{
        didSet{
            namelabel.backgroundColor = .white
        }
    }

    @IBOutlet weak var leftBtn: UIButton!{
        didSet{
            leftBtn.backgroundColor = .white
        }
    }

    @IBOutlet weak var iconView: UIImageView!{
        didSet{
            iconView.layer.cornerRadius = 25
            iconView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var memoLabel: UILabel!{
        didSet{
            memoLabel.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var rightBtn: UIButton!{
        didSet{
            rightBtn.backgroundColor = .white
        }
    }

    override func awakeFromNib() {
        
    }
    
    
    var topic: Topic?{
        didSet{
            // 赋值
            guard  let tp = topic else { return }
            namelabel.text =  tp.info?.topic_name
//            iconView.kf.setImage(with: URL(string: (tp.info?.avatar)!), placeholder: nil, options: nil, progressBlock: nil) { [weak self] (img, _, _, _) in
//                self?.iconView.image = img?.kf.image(withRoundRadius: 50, fit: CGSize(width: 100, height: 100))
//            }
            iconView.kf.setImage(with: URL(string:  (tp.info?.avatar)!))
            memoLabel.text = tp.info?.author
        }
    }
}
