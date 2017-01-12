//
//  MainTabbarController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    struct TabbarItemModel {
        var name: String
        var image: String
        var selectedImage: String
        var className: String
    }
    
    // 命名空间
    let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    
    let items: [TabbarItemModel] = [
        TabbarItemModel(name: "火柴", image: "Social_One", selectedImage: "Social_One_Select" ,className: "MatchViewController"),
        TabbarItemModel(name: "话题", image: "Social_Topic", selectedImage: "Social_Topic_Select",className: "TopicViewController"),
//        TabbarItemModel(name: "消息", image: "Social_Messages", selectedImage: "Social_Messages_Select",className: "MessageViewController"),
        TabbarItemModel(name: "盒子", image: "Social_Box", selectedImage: "Social_Box_Select",className: "BoxViewController"),
//        TabbarItemModel(name: "我", image: "Social_Private", selectedImage: "Social_Private_Select" ,className: "ProfileViewController")
                                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.backgroundImage = UIImage()
        items.forEach { self.addChildController(with: $0) }
    }
    
    init() {
       super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addChildController(with model:TabbarItemModel){
        
        guard let nameClass = NSClassFromString(nameSpace + "." + model.className)else{ return }
        let vcClass = nameClass as! UIViewController.Type
        let vc = vcClass.init()
        vc.navigationItem.title = model.name
        vc.tabBarItem.image = UIImage(named: model.image)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: model.selectedImage)?.withRenderingMode(.alwaysOriginal)
        // MARK: 这里会发现，系统的tabbarItem 图片位置不正常， top 和bottom 两个数最好绝对值相同.不然会改变图片
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        let wraped = MainNavigationController(rootViewController: vc)
        addChildViewController(wraped)
        
    }
}
