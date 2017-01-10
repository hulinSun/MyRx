//
//  MatchRecordingController.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MatchRecordingController: UIViewController {
    
    private let bag = DisposeBag()
    
    @IBOutlet weak var timeLabel: UILabel!

    /// 完成按钮
    @IBOutlet weak var doneBtn: UIButton!
    
    /// 播放按钮
    @IBOutlet weak var playBtn: UIButton!
    
    /// 录音按钮
    @IBOutlet weak var recordBtn: UIButton!
    let mgr = AudioManager.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "录音"
        view.backgroundColor = .random()
        
        playBtn.rx.tap
            .subscribe { [unowned self] _ in
                if self.playBtn.isSelected{ // 播放时暂停页面. 那么就应该继续播放
                    print("暂停播放")
                    self.mgr.pausePlay()
                }else{ // 暂停
                    print("继续播放")
                    self.mgr.play()
                }
                self.playBtn.isSelected = !self.playBtn.isSelected
            }.addDisposableTo(bag)

        recordBtn.rx.tap
            .subscribe { [unowned self] _ in
                if self.recordBtn.isSelected{ // 录音是暂停页面,那么应该继续录制
                    print("暂停录制")
                    self.mgr.pause()
                }else{
                    print("继续录制")
                    self.mgr.record()
                }
                self.recordBtn.isSelected = !self.recordBtn.isSelected
            }.addDisposableTo(bag)
        
        
        
        doneBtn.rx.tap
            .subscribe { [unowned self] _ in
                self.mgr.stopRecord()
                self.mgr.initPlayer()
            }.addDisposableTo(bag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

}
