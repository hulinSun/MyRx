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

typealias MatchTopicSection = SectionModel<String, MatchTopicFrameModel>

class MatchTopicController: UIViewController {

    var content: String?
    private let bag = DisposeBag()
    var sections: Driver<[MatchTopicSection]>!
    let dataSource = RxTableViewSectionedReloadDataSource<MatchTopicSection>()
    
    struct Reuse {
        static let topicCell = ReusableCell<MatchTopicCell>() // tr th
        static let recommendCell = ReusableCell<RecommendCell>() // tru
        static let attentionCell = ReusableCell<MatchAttentionCell>(nibName:  "MatchAttentionCell") // tl
    }
    
    fileprivate lazy var rowCache: [String: CGFloat] = {
        var i = [String:CGFloat]()
        return i
    }()

    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect.zero, style: .grouped)
        i.separatorStyle = .none
        i.register(Reuse.topicCell)
        i.register(Reuse.recommendCell)
        i.register(Reuse.attentionCell)
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
            let elem = element.topic
            if elem.type == "th" || elem.type == "tr"{
                let cell = tv.dequeue(Reuse.topicCell, for: indexPath)
                cell.topicFrame = element
                cell.selectionStyle = .none
                return cell
            }else if elem.type == "tl"{
                let cell = tv.dequeue(Reuse.attentionCell, for: indexPath)
                Observable.of(elem)
                    .bindTo(cell.rx.topic)
                    .addDisposableTo(self.bag)
                cell.selectionStyle = .none
                return cell
            }else if elem.type == "tru"{
                let cell = tv.dequeue(Reuse.recommendCell, for: indexPath)
                cell.topic = elem
                cell.selectionStyle = .none
                return cell
            }
            return UITableViewCell()
        }
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { indexPath in
                print("点击了 \(indexPath.row) 行")
            }).addDisposableTo(bag)
        
//        sections
//            .drive(tableView.rx.items(dataSource: dataSource))
//            .addDisposableTo(bag)
    }
    
    func setupData() {
        
        HttpService.getHomeMomentSad { (m) in
            // 缓存图片。异步绘图
            let xx = m.flatMap{$0?.info}
                .filter{ $0.topic_type == "imagetext"}
                .map{$0.thumb_org}
                .filter{($0?.characters.count)! > 3}
                .flatMap{$0}
            MatchDrawImageTool.asyncCacheImage(with: xx){
                let models = m.flatMap({ (tp) -> MatchTopicFrameModel in
                    return MatchTopicFrameModel(topic: tp!)
                })
                let sec = MatchTopicSection(model: "", items: models)
                self.sections = Observable.of([sec]).asDriver(onErrorJustReturn: [])
                self.sections
                    .drive(self.tableView.rx.items(dataSource: self.dataSource))
                    .addDisposableTo(self.bag)
            }
        }
        
        
        let provider = RxMoyaProvider<MatchService>(stubClosure: MoyaProvider.immediatelyStub)
        provider
            .request(.likemomentsad)
            .filterSuccessfulStatusCodes()
            .observeOn(.main)
            .subscribe { (e) in
                guard let response = e.element else{ return }
                if let m = response.mapArray(Topic.self, designatedPath: "data"){
                    // MARK : 注意，这里flatMap 返回的值是盒子里的值，返回未包装过的。 如果是map 的话，返回的则是一个盒子，就包装过的、
                    // for case let topic? in m { } // 模式匹配
                    print(m.count)
                }
            }.addDisposableTo(bag)
    }
}


extension MatchTopicController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let frames = dataSource[indexPath.section].items
        let tpFrame = frames[indexPath.row]
        let tp = tpFrame.topic
        
        var height:CGFloat = 0
        if let cacheH = rowCache[tp.lastid!]{
            height = cacheH
        }else{ // 计算
            var calucteHeight: CGFloat = 0
            if  tp.type == "th" || tp.type == "tr" {
                calucteHeight = tpFrame.cellHeight
            }else if tp.type == "tl"{
                calucteHeight = 144
            }else if tp.type == "tru"{
                calucteHeight = 277
            }
            rowCache[tp.lastid!] = calucteHeight
            height = calucteHeight
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
