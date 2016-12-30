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
    let dataSource = RxTableViewSectionedReloadDataSource<TopicListSection>()
    struct Reuse {
        static let cell = ReusableCell<TopicTitleCell>(nibName: "TopicTitleCell")
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
            cell.config(element)
            return cell
        }
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("点击了 \(indexPath.row) 行")
        }).addDisposableTo(bag)
        
        viewModel.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)
        viewModel.navigationBarTitle
            .drive(self.navigationItem.rx.title)
            .addDisposableTo(bag)
    }
}



extension TopicViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.text = "-----\(dataSource[section].model.name)"
        label.backgroundColor = .red
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
