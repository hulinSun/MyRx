//
//  MatchTopicCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class MatchTopicCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 头部的view
     lazy var topView: TopicTopView = {
        let i = TopicTopView.loadFromNib()
        return i
    }()
    /// 图片
     lazy var photoView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        return i
    }()
    /// 文本
     lazy var descLabel: UILabel = {
        let i = UILabel()
        i.font = UIFont.systemFont(ofSize: 14)
        i.textColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
        i.numberOfLines = 10
        i.preferredMaxLayoutWidth = UIConst.screenWidth - 20
        return i
    }()
    /// 底部的view
     lazy var bottomView: TopicBottomView = {
        let i = TopicBottomView.loadFromNib()
        return i
    }()
    /// 显示更多 ，收起按钮
     lazy var openBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    
    var topic: Topic?{
        didSet{
            contentView.subviews.forEach{$0.snp.removeConstraints()}
            // 赋值
            bindData()
            
            // 布局
            layoutWithData()
        }
    }
    
    
     func bindData(){
        
        guard  let tp = topic else { return }
        
//     
        topView.topic = tp
        bottomView.topic = tp
        if let org = tp.info?.thumb_org { // 有图片
//            photoView.kf.setImage(with: URL(string: org))
            photoView.kf.setImage(with: URL(string: org), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (img, _, _, _) in
                
                self.photoView.image = img?.kf.resize(to: CGSize(width: UIConst.screenWidth, height:  UIConst.screenWidth))
            })
        }
        if let cot = tp.info?.content {
            descLabel.text = cot.replacingOccurrences(of: "<br>", with: "\n")
        }
    }
    
     func layoutWithData(){
        
        guard  let tp = topic else { return }
        topView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(128)
            make.top.equalToSuperview()
        }
        normalLayout(with: tp)
    }
    
    func normalLayout(with tp:Topic)  {
        
        if (tp.info?.thumb_org?.contains("http"))!{ // 有图片
            photoView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(UIConst.screenWidth)
                make.top.equalTo(topView.snp.bottom)
            }
            photoView.isHidden = false
            if tp.info?.content != nil { // 有文本
                descLabel.isHidden = false
                descLabel.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(photoView.snp.bottom).offset(10)
                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(descLabel.snp.bottom)
                    make.bottom.equalToSuperview()
                }
            }else{ // 有图片 没文本
                descLabel.isHidden = true
                // 这里没图片，让他的高度约束为0.01
//                descLabel.snp.makeConstraints{ (make) in
//                    make.left.equalToSuperview().offset(10)
//                    make.right.equalToSuperview().offset(-10)
//                    make.top.equalTo(photoView.snp.bottom)
//                    make.height.equalTo(0.01)
//                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(photoView.snp.bottom)
                    make.bottom.equalToSuperview()
                }
            }
        }else{ // 没图片
            photoView.isHidden = true
//            photoView.snp.makeConstraints { (make) in
//                make.left.right.equalToSuperview()
//                make.height.equalTo(0.001)
//                make.top.equalTo(topView.snp.bottom)
//            }
            if tp.info?.content != nil { // 有文本
                descLabel.isHidden = false
                descLabel.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(topView.snp.bottom).offset(10)
                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(descLabel.snp.bottom)
                    make.bottom.equalToSuperview()
                }
            }else{ // 没文本
                descLabel.isHidden = true
                descLabel.snp.makeConstraints{ (make) in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(photoView.snp.bottom)
                    make.height.equalTo(0.01)
                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(topView.snp.bottom)
                    make.bottom.equalToSuperview()
                }
            }
        }
    }
    
     func setupUI(){
        contentView.addSubview(topView)
        contentView.addSubview(photoView)
        contentView.addSubview(descLabel)
        contentView.addSubview(openBtn)
        contentView.addSubview(bottomView)
    }
}
