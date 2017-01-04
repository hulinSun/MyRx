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
    
    // Input (从外面传进来的信号。让里面知道的)
    var creatTopicButtonDidTap: PublishSubject<Void> { get }
    var categoryButtonDidTap: PublishSubject<Void> { get }
    var searchDidTap: PublishSubject<String> { get }
    
    // Output (从里面传出去的信号。让外面知道)
    var navigationBarTitle: Driver<String?> { get }
    var sections: Driver<[TopicListSection]> { get }
}




// TODO: 废弃，不用了
class TopicListViewModel: TopicListViewModelType {
    
    // MARK: 本来尝试着用MVVM写一下。无奈思想层面不够。加上再把事件抽离信号，脑子很混乱。所以暂时使用MVC 的方式。 以后再尝试着改一下
    
    let elements: Variable<[TopicGroup]>
    private let bag = DisposeBag()
    
    // MARK: Input
    
    let creatTopicButtonDidTap = PublishSubject<Void>()
    let categoryButtonDidTap = PublishSubject<Void>()
    var searchDidTap = PublishSubject<String>()
    
    
    // MARK: Output
    let navigationBarTitle: Driver<String?>
    let sections: Driver<[TopicListSection]>
    
    init() {
        self.navigationBarTitle = .just("😝")
        let elems = Variable([TopicGroup]())
        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else { return }
                if let model = response.mapObject(TopicList.self, designatedPath: "data.list"){ elems.value = model.topic_group_list! }
            }.addDisposableTo(bag)
        
        self.elements = elems
        let sections = elems.value.map { (gp) -> TopicListSection  in
           return TopicListSection(model: gp, items: gp.topic_list!)
        }
        self.sections = Observable.of(sections).asDriver(onErrorJustReturn: [])
        
        creatTopicButtonDidTap.asObserver().subscribe { (e) in
            print("在viewModel Li知道了点击")
        }.addDisposableTo(bag)
        
    }
    
    
    // MARK : 注意Swift 的初始化规则，在Swift 初始化方法中。在你没有保证所有的成员属性有值的时候，你在初始化方法中调用方法。那么会有错误。一定要保证所有的属性有值的时候才能用self
    func requestData() {
        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else { return }
                if let model = response.mapObject(TopicList.self, designatedPath: "data.list"){
                    self.elements.value = model.topic_group_list!
                }
            }.addDisposableTo(bag)
    }
}
