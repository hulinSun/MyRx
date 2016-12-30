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
import SnapKit
import ReusableKit
import Moya

/// 话题控制器
class TopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect.zero, style: .grouped)
        i.register(Reuse.cell)
        return i
    }()
    
    
    struct Reuse {
        static let cell = ReusableCell<TopicTitleCell>()
    }

    private func setupUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func other()  {
        
        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else { return }
                if let model = response.mapObject(TopicList.self, designatedPath: "data.list"){
                    print(model)
                }
            }.addDisposableTo(DisposeBag())
    }

}
