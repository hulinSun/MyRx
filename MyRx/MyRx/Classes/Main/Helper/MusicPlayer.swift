
//
//  MusicPlayer.swift
//  MyRx
//
//  Created by Hony on 2017/1/12.
//  Copyright © 2017年 Hony. All rights reserved.
//

import UIKit
import AVFoundation

/// 这里不把他设计成单例的原因是，这个工具类牵扯
class MusicPlayer: NSObject {

    var musics: [Music]
    
    /// 初始化方法
     init(musics: [Music]) {
        self.musics = musics
        super.init()
    }
}
