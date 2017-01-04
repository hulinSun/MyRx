//
//  MatchViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import HandyJSON
import Moya

/// 首页的火柴控制器
class MatchViewController: UIViewController {

    let bag = DisposeBag()
    
    fileprivate lazy var leftBtn: UIButton = {
        let i = UIButton()
        i.setTitle("发帖", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(UIColor("#687880"), for: .normal)
        return i
    }()
    
    
    fileprivate lazy var seg: UISegmentedControl = {
        let i = UISegmentedControl(items: ["好友","欢喜"])
        i.layer.cornerRadius = 14
        i.clipsToBounds = true
        i.tintColor = UIConst.themeColor
        return i
    }()
    
    
    fileprivate lazy var matchSeg: MatchSegmentedControl = {
        let i = MatchSegmentedControl(items: ["好友","欢喜"])
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI()  {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        navigationItem.titleView = matchSeg
        matchSeg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 130, height: 28))
        }
        
        // MARK : TARGET-ACTION 机制
        matchSeg.rx.controlEvent(.valueChanged).subscribe { (e) in
            print("-------\(self.matchSeg.selectedIndex)")
        }.addDisposableTo(bag)
        
    }
    
    
    func setupData() {
        
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        
        provider
            .request(.likemomentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    print(m.first??.info?.avatar ?? "😝")
                    // MARK : 注意，这里flatMap 返回的值是盒子里的值，返回未包装过的。 如果是map 的话，返回的则是一个盒子，就包装过的、
                    //                    print(m.flatMap{ $0?.info?.content })
                    
                    //                    for case let topic? in m { // 模式匹配
                    //                        print(topic.info?.content ?? "xixi")
                    //                    }
                }
            }.addDisposableTo(bag)
        
        
        /// momentsad
        
        provider
            .request(.momentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    //                    print(m.flatMap{ $0?.info?.content })
                    print(m.count)
                }
            }.addDisposableTo(bag)
    }
}
