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
import SnapKit
import ReusableKit
import RxDataSources

/// 话题控制器
class TopicViewController: UIViewController {

    let bag = DisposeBag()
    let viewModel = TopicListViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<TopicListSection>()
    struct Reuse {
        static let cell = ReusableCell<TopicTitleCell>(nibName: "TopicTitleCell")
        static let header = ReusableView<TopicSectionHeaderView>(nibName: "TopicSectionHeaderView")
        
    }

    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect.zero, style: .grouped)
        i.register(Reuse.cell)
        i.register(Reuse.header)
        i.estimatedRowHeight = 50
        i.rowHeight = UITableViewAutomaticDimension
        return i
    }()
    
    fileprivate lazy var leftBtn: UIButton = {
        let i = UIButton()
        i.setTitle("创建话题", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(.red, for: .normal)
        return i
    }()
    
    fileprivate lazy var rightBtn: UIButton = {
        let i = UIButton()
        i.setTitle("分类", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(.blue, for: .normal)
        return i
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI(){
        
        leftBtn.rx.controlEvent(.touchUpInside).subscribe { _ in
            print("点击了按钮")
        }.addDisposableTo(bag)
        
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        rightBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 45, height: 20))
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.delegate = nil
        tableView.dataSource = nil
        
        tableView.rx.setDelegate(self).addDisposableTo(bag)
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeue(Reuse.cell, for: indexPath)
            cell.selectionStyle = .none
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
        let sectionHeader = tableView.dequeue(Reuse.header)
        sectionHeader?.config(group: dataSource[section].model)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
