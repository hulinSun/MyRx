//
//  ScrollVoiceView.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

@IBDesignable

class ScrollVoiceView: UIView {
    
    fileprivate lazy var scrollView: UIScrollView = {
        let i = UIScrollView()
        i.bounces = false
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        return i
    }()
    
    var datas: [String]
    let itemW: CGFloat = 4
    let margin: CGFloat = 2
    let mutibyScale: Double = 50
    fileprivate lazy var items: [CALayer] = {
        let i = [CALayer]()
        return i
    }()
    
    init(frame: CGRect,datas: [String]) {
        self.datas = datas
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI(){
        // 添加scrollView
        self.addSubview(scrollView)
        backgroundColor = .white
        scrollView.backgroundColor = .white
        // 添加图层
        for _ in 0..<datas.count - 1{
            let layer = CALayer()
            layer.backgroundColor = UIColor("#d3d3d1").cgColor
            layer.anchorPoint = CGPoint.zero
            scrollView.layer.addSublayer(layer)
            items.append(layer)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        let  sizeWidth = CGFloat(datas.count) * (itemW + margin) - margin
        scrollView.contentSize = CGSize(width: sizeWidth, height: 0)
        for (idx,lay) in items.enumerated(){
            // 设置位置
            let heightScale = Double(datas[idx])!
            lay.bounds = CGRect(x: 0, y: 0, width: itemW, height: CGFloat(heightScale * mutibyScale))
            let ax = CGFloat(idx) * (itemW + margin)
            lay.position = CGPoint(x: ax , y:self.height -  CGFloat(heightScale * mutibyScale))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
