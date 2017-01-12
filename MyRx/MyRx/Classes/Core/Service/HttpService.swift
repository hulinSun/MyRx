//
//  HttpService.swift
//  MyRx
//
//  Created by Hony on 2017/1/11.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import HandyJSON

/// 对rxmoya 的一层分装。不暴露，直接回调数据,降低一些耦合性。所有的moya 请求数据都在这里

class HttpService: NSObject {

    private static let bag = DisposeBag()
    class func getHomeMomentSad(callback: @escaping (([Topic?]) -> Void)){
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.momentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    callback(m)
                }
            }.addDisposableTo(bag)
    }
    
    class func getHomeMusic(callback: @escaping (([Music]) -> Void)){
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.chaifei)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Music.self, designatedPath: "data"){
                    let s = m.flatMap{$0}.filter{$0.type == "music"}
                    callback(s)
                }
            }.addDisposableTo(bag)
    }
}
