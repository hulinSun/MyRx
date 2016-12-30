//
//  TopicListViewModel.swift
//  MyRx
//
//  Created by Hony on 2016/12/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class TopicListViewModel {
    
    let elements = Variable(TopicList())
    let bag = DisposeBag()
    
    init() {
        requestData()
    }
    
    private func requestData(){
        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else { return }
                if let model = response.mapObject(TopicList.self, designatedPath: "data.list"){
                    self.elements.value = model
                }
            }.addDisposableTo(bag)
        
    }
}
