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
    
    private func setupUI(){
        contentView.addSubview(recommendLabel)
        contentView.addSubview(topView)
        contentView.addSubview(photoView)
        contentView.addSubview(descLabel)
        contentView.addSubview(openBtn)
        contentView.addSubview(bottomView)
    }
}
