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
    
    fileprivate lazy var matchSeg: MatchSegmentedControl = {
        let i = MatchSegmentedControl(items: ["好友","欢喜"])
        return i
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let i = UIScrollView()
        i.contentSize = CGSize(width: 2 * UIConst.screenWidth, height: UIConst.screenHeight)
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.backgroundColor = .random()
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()  {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        // 添加自控制器
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "topicSegmentSearch", target: self,  action: "searchClick")
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        navigationItem.titleView = matchSeg
        matchSeg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 130, height: 28))
        }
        
        // MARK : TARGET-ACTION 机制
        matchSeg.rx
            .controlEvent(.valueChanged)
            .subscribe { (e) in
                print("-------\(self.matchSeg.selectedIndex)")
        }.addDisposableTo(bag)
        
        // 信号机制. 里面的任何改变。在外面都能订阅到
        matchSeg.indexChanged
            .asObservable()
            .subscribe { (e) in
                print("\(e.element ) +++++")
            }.addDisposableTo(bag)
        
    }
    
    
    func searchClick() {
        print("点击了搜索")
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
