//
//  MatchRecordingController.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit

class MatchRecordingController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!

    /// 完成按钮
    @IBOutlet weak var doneBtn: UIButton!
    
    /// 播放按钮
    @IBOutlet weak var playBtn: UIButton!
    
    /// 播放按钮
    @IBOutlet weak var recordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "录音"
        view.backgroundColor = .random()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }

}
