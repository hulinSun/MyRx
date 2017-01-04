//
//  MatchSegmentedControl.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

 class MatchSegmentedControl: UIControl {
    
    private let bag = DisposeBag()
    
    private var selectedBtn: UIButton!
    
    let i = UISegmentedControl()
    
    var titles: [String]!

    var numberOfSegments: Int{
        return titles.count
    }
    
    var selectedIndex: Int{
        set{
            if newValue > numberOfSegments { return }
            if let btn = (self.subviews.filter { $0.tag == newValue }.first as? UIButton){
                tapBtn(btn)
            }
        }
        get{
            if self.selectedBtn != nil {
                return self.selectedBtn.tag
            }else{
                return 0
            }
        }
    }
    
     init(items: [String]?) {
        
        titles = items
        super.init(frame: .zero)
        for i in 0..<titles.count{
            // 创建按钮
            let btn = UIButton()
            btn.tag = i
            btn.setTitle(titles[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIConst.themeColor, for: .normal)
            btn.setTitleColor(.white, for: .selected)
            btn.setBackgroundImage(UIImage.creatImage(with:UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1) ), for: .normal)
            btn.setBackgroundImage(UIImage.creatImage(with: UIConst.themeColor), for: .selected)
            addSubview(btn)
            btn.addTarget(self, action: #selector(tapBtn), for: UIControlEvents.touchUpInside)
            if i == 0 {
                tapBtn(btn)
            }
        }
    }
    
    func tapBtn(_ btn: UIButton) {
        
        btn.isSelected = true
        if self.selectedBtn != nil {
            self.selectedBtn.isSelected = false
        }
        self.selectedBtn = btn
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.height * 0.5
        self.clipsToBounds = true
        self.layer.borderColor = UIConst.themeColor.cgColor
        self.layer.borderWidth = 1
        for i in 0..<self.subviews.count{
            let btn = self.subviews[i]
            let size = CGSize(width: CGFloat(self.width) /  CGFloat(self.subviews.count), height: self.height)
            btn.frame = CGRect(x: CGFloat(i) * CGFloat(size.width), y: 0, width: size.width, height: self.height)
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
