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
import Kingfisher
import Moya

/// 话题控制器
class TopicViewController: UIViewController {

    let bag = DisposeBag()
    
    var sections: Driver<[TopicListSection]>!
    var banners: Variable<[TopicBanner]>!
    
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
        i.setTitleColor(UIColor("#687880"), for: .normal)
        return i
    }()
    
    fileprivate lazy var rightBtn: UIButton = {
        let i = UIButton()
        
        
        i.setTitle("分类", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(UIColor("#3daafc"), for: .normal)
        return i
    }()
    
    fileprivate lazy var adView: MatchADView = { () -> MatchADView<TopicBanner> in
        let i = MatchADView<TopicBanner>(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 175))
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        
    }
    
    private func setupUI(){
    
        tableView.tableHeaderView = adView
        adView.images = banners.value
        banners.asObservable()
            .bindTo(adView.rx.banners)
            .addDisposableTo(bag)
        
        adView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: UIConst.screenWidth, height: 175))
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        view.addSubview(tableView)
        
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 20))
        }
        rightBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 45, height: 20))
        }
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
        
        sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)
        
        leftBtn.rx.controlEvent(.touchUpInside).subscribe { _ in
            print("点击了按钮")
            }.addDisposableTo(bag)
    }
    
    
    func setupData()  {
        
        banners = Variable([TopicBanner]())
        let elems = Variable([TopicGroup]())
        let provider = RxMoyaProvider<TopicService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.index)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else { return }
                if let model = response.mapObject(TopicList.self, designatedPath: "data.list"){
                    elems.value = model.topic_group_list!
                    self.banners.value = model.banner!
                }
            }.addDisposableTo(bag)
        
        
        let sections = elems.value.map { (gp) -> TopicListSection  in
            return TopicListSection(model: gp, items: gp.topic_list!)
        }
        self.sections = Observable.of(sections).asDriver(onErrorJustReturn: [])
    }
    
}



extension TopicViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sectionHeader = tableView.dequeue(Reuse.header)
        sectionHeader?.config(group: dataSource[section].model)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
}
