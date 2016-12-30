//
//  TopicViewController.swift
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

/// 话题控制器
class TopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)

        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(MainScheduler.instance)
            .subscribe { (e) in
            guard let response = e.element else { return }
            if let r = try? response.mapString(){
                print(r)
            }
        }.addDisposableTo(DisposeBag())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
