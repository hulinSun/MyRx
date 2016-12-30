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
import RxOptional
import RxDataSources

/// 话题控制器
class TopicViewController: UIViewController {

    let bag = DisposeBag()
    let viewModel = TopicListViewModel()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<TopicGroup, TopicInfo>>()
    
    struct Reuse {
        static let cell = ReusableCell<TopicTitleCell>()
    }

    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect.zero, style: .grouped)
        i.register(Reuse.cell)
        i.estimatedRowHeight = 50
        i.rowHeight = UITableViewAutomaticDimension
        return i
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    private func setupUI(){
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = nil
        tableView.dataSource = nil
        
        tableView.rx.setDelegate(self).addDisposableTo(bag)
        
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeue(Reuse.cell, for: indexPath)
            return cell
        }
    }
    

}



extension TopicViewController: UITableViewDelegate{
    
}
