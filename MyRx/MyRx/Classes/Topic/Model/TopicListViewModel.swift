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
import RxCocoa
import RxDataSources

typealias TopicListSection = SectionModel<TopicGroup, TopicInfo>

protocol TopicListViewModelType {
    
    // Input
    var creatTopicButtonDidTap: PublishSubject<Void> { get }
    var categoryButtonDidTap: PublishSubject<Void> { get }
    var searchDidTap: PublishSubject<String> { get }
    
    // Output
    var navigationBarTitle: Driver<String?> { get }
//    var sections: Driver<[TopicListSection]> { get }
}


class TopicListViewModel: TopicListViewModelType {
    let bag = DisposeBag()
    
    // MARK: Input
    
    let creatTopicButtonDidTap = PublishSubject<Void>()
    let categoryButtonDidTap = PublishSubject<Void>()
    var searchDidTap = PublishSubject<String>()
    
    
    // MARK: Output

    let navigationBarTitle: Driver<String?>
//    let sections: Driver<[TopicListSection]>
    
    init() {
        self.navigationBarTitle = Observable.of("火柴盒").asDriver(onErrorJustReturn: "")
    }
    
    
    let elements = Variable(TopicList())
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
