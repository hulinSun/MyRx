//
//  MatchTopicController.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import Moya
import RxCocoa
import RxSwift
import ReusableKit
import RxDataSources

/// 火柴界面的 一些话题控制器

typealias MatchTopicSection = SectionModel<String, Topic?>

class MatchTopicController: UIViewController {

    
    var content: String?
    private let bag = DisposeBag()
    var sections: Driver<[MatchTopicSection]>!
    let dataSource = RxTableViewSectionedReloadDataSource<MatchTopicSection>()
    
    struct Reuse {
        static let topicCell = ReusableCell<MatchTopicCell>() // tr th
        static let recommendCell = ReusableCell<RecommendCell>() // tru
        static let topicTRCell = ReusableCell<MatchTopicHeaderTRCell>() // tru
        static let attentionCell = ReusableCell<MatchAttentionCell>(nibName:  "MatchAttentionCell") // tl
    }

    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect.zero, style: .grouped)
        i.register(Reuse.topicCell)
        i.register(Reuse.recommendCell)
        i.register(Reuse.attentionCell)
        i.register(Reuse.topicTRCell)
        i.estimatedRowHeight = 300
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        setupData()
        setupUI()
    }
    
    
    
    private func setupUI(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.rx.setDelegate(self).addDisposableTo(bag)
        dataSource.configureCell = { (_, tv, indexPath, element) in
            guard  let elem = element else { return UITableViewCell() }
            
            if elem.type == "th"{
                let cell = tv.dequeue(Reuse.topicCell, for: indexPath)
                cell.topic = elem
                cell.selectionStyle = .none
                return cell
            }else if elem.type == "tl"{
                let cell = tv.dequeue(Reuse.attentionCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if elem.type == "tru"{
                let cell = tv.dequeue(Reuse.recommendCell, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }else if elem.type == "tr"{
//                let cell = tv.dequeue(Reuse.topicTRCell, for: indexPath)
//                cell.topic = elem
//                cell.selectionStyle = .none
//                return cell
                let cell = UITableViewCell()
                cell.backgroundColor = .red
                return cell
            }
            return UITableViewCell()
        }
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("点击了 \(indexPath.row) 行")
            }).addDisposableTo(bag)
        
        sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)
    }
    
    func setupData() {
        
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.momentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
//                     print(m.flatMap{ $0?.info?.thumb_org })
                    let sec = MatchTopicSection(model: "", items: m)
                    self.sections = Observable.of([sec]).asDriver(onErrorJustReturn: [])
                }
            }.addDisposableTo(bag)
        
        
        
        provider
            .request(.likemomentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    // MARK : 注意，这里flatMap 返回的值是盒子里的值，返回未包装过的。 如果是map 的话，返回的则是一个盒子，就包装过的、
                    //                    for case let topic? in m { // 模式匹配
                    //                        print(topic.info?.content ?? "xixi")
                    //                    }
                    print(m.count)
                }
            }.addDisposableTo(bag)
    }
}


extension MatchTopicController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 去出模型
        let topics = dataSource[indexPath.section].items
        guard let tp = topics[indexPath.row] else{ return 44 }
        
        var height: CGFloat = 0
        if  tp.type == "th" {
            height = UITableViewAutomaticDimension
        }else if tp.type == "tl"{
            height = 118
        }else if tp.type == "tru"{
            height = 280
        }else if tp.type == "tr"{
            height = 44
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
