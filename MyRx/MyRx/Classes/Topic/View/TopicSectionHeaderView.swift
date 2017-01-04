//
//  TopicSectionHeaderView.swift
//  MyRx
//
//  Created by Hony on 2017/1/3.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import RxSwift
import RxCocoa

fileprivate enum TopicSectionHeadType: String {
    case hot, like, recommend, refresh
    
    var description: String{
        switch self {
        case .like:
            return "换一换"
        case .hot, .recommend , .refresh:
            return "更多"
        }
    }
}

class TopicSectionHeaderView: UITableViewHeaderFooterView {

  
    
    /**
    Optional("topic_hot")
    Optional("topic_like")
    Optional("topic_recommend")
    Optional("topic_refresh")*/
    
    private let bag = DisposeBag()
    
    @IBOutlet weak var groupTypeButton: UIButton!{
        didSet{
            groupTypeButton.rx
                .tap.subscribe { (e) in
                    
                }.addDisposableTo(bag)
        }
    }
    @IBOutlet weak var topicTitleLabel: UILabel!{
        didSet{
            topicTitleLabel.textColor = UIColor("#7a7a7a")
        }
    }
    
    override func awakeFromNib() {
        contentView.backgroundColor = UIColor("#f7f7f7")
    }
    
    func config(group: TopicGroup) {
        
        topicTitleLabel.text = group.name
        guard let type = TopicSectionHeadType(rawValue: group.type!.subString(from: 6))else { return }
        
        Observable.of(type)
            .bindTo(groupTypeButton.rx.sectionType)
            .addDisposableTo(bag)
    }
}


private extension Reactive where Base: UIButton {
    var sectionType: UIBindingObserver<Base, TopicSectionHeadType> {
        return UIBindingObserver(UIElement: base) { btn, sectionEnum in
            btn.setTitle(sectionEnum.description, for: .normal)
            if case .like = sectionEnum{
                btn.setImage(UIImage(named: "topicRefresh"), for: .normal)
            }else{
                btn.setImage(UIImage(named: "entityArrow"), for: .normal)
                btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 0)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
            }
        }
    }
}

