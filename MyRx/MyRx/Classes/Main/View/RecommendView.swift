//
//  RecommendView.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

/// 推荐的view

class RecommendView: UIView {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var avaterView: UIImageView!{
        didSet{
            avaterView.layer.cornerRadius = 25
            avaterView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var attenBtn: UIButton!
    @IBOutlet weak var ignoreBtn: UIButton!
    @IBOutlet weak var icon1View: UIImageView!{
        didSet{
            icon1View.layer.cornerRadius = 2
            icon1View.clipsToBounds = true
        }
    }
    @IBOutlet weak var icon2View: UIImageView!{
        didSet{
            icon2View.layer.cornerRadius = 2
            icon2View.clipsToBounds = true
        }
    }
    @IBOutlet weak var icon3View: UIImageView!{
        didSet{
            icon3View.layer.cornerRadius = 2
            icon3View.clipsToBounds = true
        }
    }
    
    var topic: Topic?{
        didSet{
            // 赋值
            guard  topic?.type == "tru" else { return }
            let info = (topic?.user_info)!
            topLabel.text = info.reason ?? ""
            avaterView.kf.setImage(with:  URL(string: info.avatar!))
            nameLabel.text = info.username ?? "匿名"
            memoLabel.text = info.signature ?? "无个性,不签名"
            
            // 第一个
            let arr = (topic?.tru_info)
            icon1View.kf.setImage(with: URL(string: (arr?.first?.thumb_org)!))
            icon2View.kf.setImage(with: URL(string: (arr?[1].thumb_org)!))
            icon3View.kf.setImage(with: URL(string: (arr?.last?.thumb_org)!))
        }
    }
}
