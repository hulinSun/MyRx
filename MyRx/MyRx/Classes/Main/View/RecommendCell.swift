//
//  RecommendCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {

    
    fileprivate lazy var recommendView: RecommendView = {
        let i = RecommendView.loadFromNib()
        return i
    }()
    
    
    fileprivate lazy var moreBtn: UIButton = {
        let i = UIButton()
        i.setTitle("更多推荐", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return i
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recommendView)
        contentView.addSubview(moreBtn)
        contentView.backgroundColor = .lightGray
        recommendView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(222)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(35)
            make.top.equalTo(recommendView.snp.bottom)
        }
        
        /// 有更多按钮的话 高度280
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
