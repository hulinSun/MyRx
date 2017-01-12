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
import UIColor_Hex_Swift

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
    
    
    fileprivate lazy var scrollVoice: ScrollVoiceView = {
        let arr = UIConst.str.components(separatedBy: ",")
        let i = ScrollVoiceView(frame:CGRect(x: 120, y: 0, width: UIConst.screenWidth - 2 * 10 - 120, height: 120)
, datas: arr)
        return i
    }()
    
    override func awakeFromNib() {
        
        let tap = UITapGestureRecognizer()
        _ = tap.rx.event.subscribe { (e) in
            self.player.play()
        }
        realView.addSubview(scrollVoice)
        self.addGestureRecognizer(tap)
        realView.layer.borderColor = UIColor("#d3d3d1").cgColor
        realView.layer.borderWidth = 1
        
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
        scrollVoice.frame = CGRect(x: 120, y: 0, width: realView.frame.width - 120, height: 120)
    }
}
