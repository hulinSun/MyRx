//
//  MatchTopicController.swift
//  MyRx
//
//  Created by Hony on 2017/1/4.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

/// 火柴界面的 一些话题控制器
class MatchTopicController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
    }
    
    var content: String?{
        didSet{
            let l = UILabel(frame: CGRect(x: 0, y: 100, width: 300, height: 66))
            l.backgroundColor = .random()
            l.text = content
            view.addSubview(l)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
