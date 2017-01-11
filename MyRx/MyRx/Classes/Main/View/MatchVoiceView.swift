//
//  MatchVoiceView.swift
//  MyRx
//
//  Created by Hony on 2017/1/9.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class MatchVoiceView: UIView {
    
    @IBOutlet weak var realView: UIView!{
        didSet{
            realView.layer.cornerRadius = 4
            realView.clipsToBounds = true
        }
    }
    fileprivate lazy var player: AVPlayer = {
        let item = AVPlayerItem(url: URL(string: "http://audio.huochaihe.com/f0ZhdfBuStBT1zwU3OUQUMDT9tQ=/FpS6E4WtxeLxvXrxFjFO5DkkUx8a")!)
        let play = AVPlayer(playerItem: item)
        return play
    }()
    
    override func awakeFromNib() {
        
        let tap = UITapGestureRecognizer()
        _ = tap.rx.event.subscribe { (e) in
            self.player.play()
        }
        self.addGestureRecognizer(tap)
    }
    
    func tapme() {
        self.player.play()
    }

    @IBOutlet weak var iconView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 10
        let padding: CGFloat = 13
        realView.frame = CGRect(x: padding, y: margin, width: UIConst.screenWidth - 2 * padding, height: 120)
        iconView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
    }
}
