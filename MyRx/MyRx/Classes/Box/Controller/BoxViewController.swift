//
//  BoxViewController.swift
//  MyRx
//
//  Created by Hony on 2016/12/29.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import ReusableKit
import SnapKit

/// 盒子控制器
class BoxViewController: UIViewController {
    
    struct Reuse {
        static let musicCell = ReusableCell<BoxMusicCell>(nibName: "BoxMusicCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "柴扉"
        HttpService.getHomeMusic { (e) in
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
