//
//  MatchViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import HandyJSON


/// 首页的火柴控制器
class MatchViewController: UIViewController {

    let bag = DisposeBag()
    
    fileprivate lazy var leftBtn: UIButton = {
        let i = UIButton()
        i.setTitle("发帖", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(UIColor("#687880"), for: .normal)
        return i
    }()
    
    fileprivate lazy var matchSeg: MatchSegmentedControl = {
        let i = MatchSegmentedControl(items: ["好友","欢喜"])
        return i
    }()
    
    fileprivate lazy var pageController: UIPageViewController = {
        let i = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return i
    }()
    
    fileprivate lazy var pageArr: [String] = {
        let i = ["0","1"]
        return i
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPageController()
        setupUI()
    }
    
    
    
    func addPageController() {
        self.automaticallyAdjustsScrollViewInsets = false
        pageController.delegate = self
        pageController.dataSource = self
        guard let matchVC = viewControllerAtIndex(idx: 0) else {return}
        pageController.setViewControllers([matchVC], direction: .reverse, animated: false, completion: nil)
        view.addSubview(pageController.view)
        pageController.view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }
        
        addChildViewController(pageController)
    }
    
    func setupUI()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "topicSegmentSearch", target: self,  action: "searchClick")
        leftBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        navigationItem.titleView = matchSeg
        matchSeg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 124, height: 26))
        }
        
        // MARK : TARGET-ACTION 机制
        matchSeg.rx
            .controlEvent(.valueChanged)
            .subscribe { [weak self](e) in
                if let strongSelf = self{
                    guard let matchVC = strongSelf.viewControllerAtIndex(idx: strongSelf.matchSeg.selectedIndex) else {return}
                    let direc: UIPageViewControllerNavigationDirection = strongSelf.matchSeg.selectedIndex == 0 ? .reverse : .forward
                    strongSelf.pageController.setViewControllers([matchVC], direction: direc, animated: true, completion: nil)
                }
            }.addDisposableTo(bag)
        
        // 信号机制. 里面的任何改变。在外面都能订阅到
        matchSeg.indexChanged
            .asObservable()
            .subscribe { _ in }.addDisposableTo(bag)
        
    }
    
    
    func searchClick() {
        print("点击了搜索")
    }
    
}


extension MatchViewController: UIPageViewControllerDelegate , UIPageViewControllerDataSource{
    
    fileprivate func viewControllerAtIndex(idx: Int)-> MatchTopicController?{
        
        if pageArr.isEmpty || idx >= pageArr.count { return nil }
        let vc = MatchTopicController()
        vc.content = self.pageArr[idx]
        return vc
    }
    
    fileprivate func indexOfViewController(controller: MatchTopicController) -> Int?{
        return pageArr.index(of: controller.content!)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard var idx = indexOfViewController(controller: viewController as! MatchTopicController) else { return nil }
        if idx == 0 || idx == NSNotFound { return nil }
        idx -= 1
        return viewControllerAtIndex(idx: idx)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var idx = indexOfViewController(controller: viewController as! MatchTopicController)else { return nil }
        if  idx == NSNotFound { return nil }
        idx += 1
        if  idx == pageArr.count { return nil }
        return viewControllerAtIndex(idx: idx)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let pre = previousViewControllers.first as? MatchTopicController else{ return }
            let idx = pre.content == "0" ? 1 : 0
            self.matchSeg.selectedIndex = idx
            self.matchSeg.special = false
        }
    }
}
