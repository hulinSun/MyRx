//
//  MatchTopicController.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift

/// 火柴界面的 一些话题控制器
class MatchTopicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        setupData()
    }
    
    private let bag = DisposeBag()
    var content: String?
    
    
    
    func setupData() {
        
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        
        provider
            .request(.likemomentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    // MARK : 注意，这里flatMap 返回的值是盒子里的值，返回未包装过的。 如果是map 的话，返回的则是一个盒子，就包装过的、
                                        print(m.flatMap{ $0?.info?.topic_name })
                    
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
//                     print(m.flatMap{ $0?.info?.content })
                }
            }.addDisposableTo(bag)
    }
    

}
