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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        
        provider
            .request(.likemomentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(MainScheduler.instance)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    print(m.first??.info?.avatar ?? "😝")
                    
                    // MARK : 注意，这里flatMap 返回的值是盒子里的值，返回未包装过的。 如果是map 的话，返回的则是一个盒子，就包装过的、
                    print(m.flatMap{ $0?.info?.content })
                    
//                    for case let topic? in m { // 模式匹配
//                        print(topic.info?.content ?? "xixi")
//                    }
                }
            }.addDisposableTo(bag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
