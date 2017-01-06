
//
//  MatchTopicCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import TextAttributes

class MatchTopicCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 头部的view
    fileprivate lazy var topView: TopicTopView = {
        let i = TopicTopView.loadFromNib()
        return i
    }()
    /// 图片
    fileprivate lazy var photoView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        i.clipsToBounds = true
        return i
    }()
    
    /// 文本
    fileprivate lazy var descLabel: UILabel = {
        let i = UILabel()
        i.numberOfLines = 10
        i.preferredMaxLayoutWidth = UIConst.screenWidth - 30
        return i
    }()
    
    /// 文本
    fileprivate lazy var recomLabel: UILabel = {
        let i = UILabel()
        i.font = UIFont.systemFont(ofSize: 14)
        i.textColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
        return i
    }()
    
    /// 底部的view
    fileprivate lazy var bottomView: TopicBottomView = {
        let i = TopicBottomView.loadFromNib()
        return i
    }()
    
    /// 显示更多 ，收起按钮
    fileprivate lazy var openBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    
    var topicFrame: MatchTopicFrameModel?{
        didSet{
            // 赋值
            bindData()
            guard let tpFrame = topicFrame else { return }
            recomLabel.frame = tpFrame.recomFrame
            topView.frame = tpFrame.topFrame
            photoView.frame = tpFrame.photoFrame
            descLabel.frame = tpFrame.descFrame
            bottomView.frame = tpFrame.bottomFrame
        }
    }
    
    
     func bindData(){
        
        guard  let tp = topicFrame?.topic else { return }
        if tp.type == "tr"{
            let str =  (tp.users?.rlist?.first?.user_name)! + " 推荐了"
            let attrStr = NSMutableAttributedString(string: str, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13),NSForegroundColorAttributeName: UIColor.lightGray])
            let range = NSRange(location: 0, length: ((tp.users?.rlist?.first?.user_name)! as NSString).length)
            attrStr.addAttributes([NSForegroundColorAttributeName: UIConst.themeColor], range: range)
            recomLabel.attributedText = attrStr
        }
        topView.topic = tp
        bottomView.topic = tp
        if let org = tp.info?.thumb_org { // 有图片
            photoView.kf.setImage(with: URL(string: org))
        }
        if let cot = tp.info?.content {
            let s = cot.replacingOccurrences(of: "<br>", with: "\n")
            let prar = NSMutableParagraphStyle()
            prar.lineSpacing = 8
            let attrs = [
                NSFontAttributeName: UIFont.systemFont(ofSize: 15),NSParagraphStyleAttributeName : prar,
                NSForegroundColorAttributeName: UIConst.themeColor
            ]
            descLabel.attributedText = NSAttributedString(string: s, attributes: attrs)
        }
    }
    
     func setupUI(){
        contentView.addSubview(recomLabel)
        contentView.addSubview(topView)
        contentView.addSubview(photoView)
        contentView.addSubview(descLabel)
        contentView.addSubview(openBtn)
        contentView.addSubview(bottomView)
    }
}
