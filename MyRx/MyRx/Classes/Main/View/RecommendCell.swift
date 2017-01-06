//
//  RecommendCell.swift
//  MyRx
//
//  Created by Hony on 2017/1/5.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
class RecommendCell: UITableViewCell {

    
    fileprivate lazy var recommendView: RecommendView = {
        let i = RecommendView.loadFromNib()
        return i
    }()
    
    
    fileprivate lazy var lay1: CALayer = {
        let i = CALayer()
        i.backgroundColor = UIColor("#f1f1f2").cgColor
        i.anchorPoint = CGPoint.zero
        i.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 0.7)
        return i
    }()
    
    
    fileprivate lazy var lay2: CALayer = {
        let i = CALayer()
        i.backgroundColor = UIColor("#e3e3e5").cgColor
        i.anchorPoint = CGPoint.zero
        i.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 0.7)
        return i
    }()
    var topic: Topic?{
        didSet{
            // 赋值
            recommendView.topic = topic
        }
    }

    fileprivate lazy var moreBtn: UIButton = {
        let i = UIButton()
        i.setTitle("更多推荐", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        i.setTitleColor(.lightGray, for: .normal)
        i.backgroundColor = .white
        return i
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(recommendView)
        contentView.addSubview(moreBtn)
        contentView.backgroundColor = UIColor("#fafafa")
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
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lay1.position = CGPoint(x: 0, y: 230)
        self.layer.addSublayer(lay1)
        
        lay2.position = CGPoint(x: 0, y: 266.3)
        self.layer.addSublayer(lay2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
