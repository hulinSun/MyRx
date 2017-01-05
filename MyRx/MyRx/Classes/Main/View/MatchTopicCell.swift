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
    
    
    /// 头部推荐的label
    fileprivate lazy var recommendLabel: UILabel = {
        let i = UILabel()
        return i
    }()
    /// 头部的view
    fileprivate lazy var topView: TopicTopView = {
        let i = TopicTopView.loadFromNib()
        return i
    }()
    /// 图片
    fileprivate lazy var photoView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    /// 文本
    fileprivate lazy var descLabel: UILabel = {
        let i = UILabel()
        i.font = UIFont.systemFont(ofSize: 14)
        i.textColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 30/255.0, alpha: 1)
        i.numberOfLines = 10
        i.preferredMaxLayoutWidth = UIConst.screenWidth - 20
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
    
    
    var topic: Topic?{
        didSet{
            // 赋值
            bindData()
            
            // 布局
            layoutWithData()
        }
    }
    
    
    private func bindData(){
        
        guard  let tp = topic else { return }
        
        if tp.type == "tr"{ // 推荐
            recommendLabel.text = tp.users?.rlist?.first?.user_name ?? "推荐了"
        }
        topView.topic = tp
        bottomView.topic = tp
        if let org = tp.info?.thumb_org { // 有图片
            photoView.kf.setImage(with: URL(string: org))
        }
        if let cot = tp.info?.content {
            descLabel.text = cot
        }
    }
    
    private func layoutWithData(){
        
        guard  let tp = topic else { return }
        
        if tp.type == "tr"{ // 推荐
            recommendLabel.isHidden = false
            recommendLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.equalToSuperview().offset(15)
                make.height.equalTo(20)
                make.right.equalToSuperview().offset(-15)
            }
            
            topView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(128)
                make.top.equalTo(recommendLabel.snp.bottom)
            }
        }else if tp.type == "th"{ // 正常
            recommendLabel.isHidden = true
            topView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(128)
                make.top.equalToSuperview()
            }
        }
        
        if tp.info?.thumb_org != nil { // 有图片
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
                    make.top.equalTo(photoView.snp.bottom)
                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(descLabel.snp.bottom)
                }
            }else{ // 有图片 没文本
                descLabel.isHidden = true
                
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(photoView.snp.bottom)
                }
            }
        }else{ // 没图片
            photoView.isHidden = true
            if tp.info?.content != nil { // 有文本
                descLabel.isHidden = false
                descLabel.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                    make.top.equalTo(topView.snp.bottom)
                }
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(descLabel.snp.bottom)
                }
            }else{ // 没文本
                descLabel.isHidden = true
                bottomView.snp.makeConstraints { (make) in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(50)
                    make.top.equalTo(topView.snp.bottom)
                }
            }
        }
    }
    
    private func setupUI(){
        contentView.addSubview(recommendLabel)
        contentView.addSubview(topView)
        contentView.addSubview(photoView)
        contentView.addSubview(descLabel)
        contentView.addSubview(openBtn)
        contentView.addSubview(bottomView)
    }
}
